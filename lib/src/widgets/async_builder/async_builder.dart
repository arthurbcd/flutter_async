import 'dart:async';

import 'package:async_notifier/async_notifier.dart';
import 'package:flutter/material.dart';

import '../../utils/async_state.dart';
import '../async/async.dart';

/// A [Widget] that listens to [Future] and [Stream] events.
@immutable
class AsyncBuilder<T> extends StatefulWidget {
  /// Creates an [AsyncBuilder] with [future] or [stream] as functions.
  ///
  /// This constructor is useful when you want to cache & reload [future] and [stream]
  /// callbacks, persisting state. Add [interval] to reload them periodically.
  const AsyncBuilder({
    super.key,
    this.initialData,
    this.onData,
    this.interval,
    this.future,
    this.stream,
    this.alignment = Alignment.center,
    this.noneBuilder = _noneBuilder,
    this.errorBuilder = _errorBuilder,
    this.loadingBuilder = _loadingBuilder,
    this.reloadingBuilder = _reloadingBuilder,
    this.skipReloading = false,
    required this.builder,
  }) : assert(
         future == null || stream == null,
         'cannot set both future and stream',
       ),
       snapshot = null,
       futureValue = null,
       streamValue = null;

  /// Creates an [AsyncBuilder] with [futureValue] or [streamValue].
  ///
  /// This constructor is useful when you want to manage a single [Future] or [Stream]
  /// without caching or reloading. It's state must be stored elsewhere.
  const AsyncBuilder.value({
    super.key,
    this.snapshot,
    this.initialData,
    this.onData,
    Future<T>? future,
    Stream<T>? stream,
    this.alignment = Alignment.center,
    this.noneBuilder = _noneBuilder,
    this.errorBuilder = _errorBuilder,
    this.loadingBuilder = _loadingBuilder,
    this.reloadingBuilder = _reloadingBuilder,
    this.skipReloading = false,
    required this.builder,
  }) : assert(
         future == null || stream == null,
         'Cannot set both future and stream',
       ),
       futureValue = future,
       streamValue = stream,
       stream = null,
       future = null,
       interval = null;

  /// Creates an paged [AsyncBuilder] with [future] function.
  ///
  /// This constructor is useful when you want to paginate data. Use [builder] to
  /// show the list of data and attach the [ScrollController] to the list scroll.
  ///
  /// You can provide your own [scrollController] or a default will be created.
  static Widget paged<T>({
    Key? key,
    required Future<List<T>> Function(int page) future,
    required AsyncPagedBuilder<T> builder,
    List<T> initialData = const [],
    int initialPage = 0,
    ValueChanged<List<T>>? onData,
    Duration? interval,
    AlignmentGeometry alignment = Alignment.center,
    bool skipReloading = true,
    WidgetBuilder reloadingBuilder = _reloadingBuilder,
    ErrorBuilder errorBuilder = _errorBuilder,
    WidgetBuilder loadingBuilder = _loadingBuilder,
    WidgetBuilder scrollLoadingBuilder = Async.scrollLoadingBuilder,
    ScrollController? scrollController,
  }) {
    return _AsyncPagedBuilder<T>(
      key: key,
      future: future,
      builder: builder,
      initialData: initialData,
      initialPage: initialPage,
      onData: onData,
      interval: interval,
      alignment: alignment,
      skipReloading: skipReloading,
      reloadingBuilder: reloadingBuilder,
      errorBuilder: errorBuilder,
      loadingBuilder: loadingBuilder,
      scrollLoadingBuilder: scrollLoadingBuilder,
      scrollController: scrollController ?? ScrollController(),
    );
  }

  static Widget _reloadingBuilder(BuildContext context) {
    final builder = Async.of(context).builderConfig?.reloadingBuilder;
    if (builder != null) return builder(context);

    return Async.reloadingBuilder(context);
  }

  static Widget _noneBuilder(BuildContext context) {
    final builder = Async.of(context).builderConfig?.noneBuilder;
    if (builder != null) return builder(context);

    return Async.noneBuilder(context);
  }

  static Widget _loadingBuilder(BuildContext context) {
    final builder = Async.of(context).builderConfig?.loadingBuilder;
    if (builder != null) return builder(context);

    return Async.loadingBuilder(context);
  }

  static Widget _errorBuilder(BuildContext context, Object e, StackTrace s) {
    final builder = Async.of(context).builderConfig?.errorBuilder;
    if (builder != null) return builder(context, e, s);

    return Async.errorBuilder(context, e, s);
  }

  /// The [AsyncSnapshot] to resolve.
  ///
  /// Setting this override the internal `AsyncNotifier.snapshot`.
  final AsyncSnapshot<T>? snapshot;

  /// The initial [T] data to pass to [builder].
  final T? initialData;

  /// The result of `future/stream` when data changes.
  final ValueChanged<T>? onData;

  /// The [Future] to listen.
  final Future<T>? futureValue;

  /// The [Future] function to load and listen.
  final Future<T> Function()? future;

  /// The [Stream] to listen.
  final Stream<T>? streamValue;

  /// The [Stream] function to load and listen.
  final Stream<T> Function()? stream;

  /// The interval to reload `future/stream` callbacks.
  final Duration? interval;

  /// How builders should be aligned.
  final AlignmentGeometry? alignment;

  /// Whether to skip reloading state.
  final bool skipReloading;

  /// The [WidgetBuilder] to show while reloading and has error or data.
  final WidgetBuilder reloadingBuilder;

  /// The [WidgetBuilder] to show while error and data are null.
  final WidgetBuilder noneBuilder;

  /// The [ErrorBuilder] to show on errors.
  final ErrorBuilder errorBuilder;

  /// The [WidgetBuilder] to show while loading.
  final WidgetBuilder loadingBuilder;

  /// The [DataBuilder] to show on data.
  final DataBuilder<T> builder;

  /// Returns the first [AsyncBuilderState] above this [context].
  static AsyncBuilderState<T> of<T>(BuildContext context) {
    final state = context.findAncestorStateOfType<AsyncBuilderState<T>>();
    assert(state != null, 'No AsyncBuilder of this context');
    return state!;
  }

  @override
  State<AsyncBuilder<T>> createState() => AsyncBuilderState();
}

/// The [State] of [AsyncBuilder].
class AsyncBuilderState<T> extends AsyncState<AsyncBuilder<T>, T> {
  Timer? _timer;

  @override
  T? get initialData => widget.initialData;

  @override
  void initState() {
    // `AsyncBuilder`
    if (widget.futureValue != null) async.future = widget.futureValue;
    if (widget.streamValue != null) async.stream = widget.streamValue;

    // `AsyncBuilder.function`
    if (widget.future != null || widget.stream != null) {
      reload();
      _setInterval(widget.interval);
    }

    super.initState();
  }

  /// Reloads `future` or `stream` function of an [AsyncBuilder].
  void reload() {
    assert(
      widget.future != null || widget.stream != null,
      'Tried to reload an `AsyncBuilder` without functions. In order to use '
      '`reload()`, you must use `AsyncBuilder.function` constructor.',
    );
    if (widget.future != null) async.future = widget.future!();
    if (widget.stream != null) async.stream = widget.stream!();
  }

  void _setInterval(Duration? interval) {
    _timer?.cancel();
    if (interval != null) {
      _timer = Timer.periodic(interval, (_) => reload());
    }
  }

  @override
  void onSnapshot(AsyncSnapshot<T> snapshot) {
    snapshot.whenOrNull(data: widget.onData);
    super.onSnapshot(snapshot);
  }

  @override
  void didUpdateWidget(covariant AsyncBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.futureValue != oldWidget.futureValue &&
        widget.futureValue != null) {
      async.future = widget.futureValue;
    }
    if (widget.streamValue != oldWidget.streamValue &&
        widget.streamValue != null) {
      async.stream = widget.streamValue;
    }
    if (widget.interval != oldWidget.interval) _setInterval(widget.interval);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final snapshot = widget.snapshot ?? async.snapshot;

    return Builder(
      builder: (context) {
        var child = snapshot.when(
          skipLoading: !widget.skipReloading,
          none: () => widget.noneBuilder(context),
          error: (e, s) => widget.errorBuilder(context, e, s),
          loading: () => widget.loadingBuilder(context),
          data: (data) => widget.builder(context, data),
        );

        if (widget.alignment != null) {
          child = Align(alignment: widget.alignment!, child: child);
        }

        if (!widget.skipReloading) {
          child = Stack(
            children: [
              child,
              if (snapshot.isReloading) widget.reloadingBuilder(context),
            ],
          );
        }

        return child;
      },
    );
  }
}

/// Signature to build the paged list of data.
///
/// You must attach this [ScrollController] for pagination.
typedef AsyncPagedBuilder<T> =
    Widget Function(
      BuildContext context,
      ScrollController controller,
      List<T> data,
    );

class _AsyncPagedBuilder<T> extends StatefulWidget {
  const _AsyncPagedBuilder({
    required super.key,
    required this.future,
    required this.builder,
    required this.initialData,
    required this.initialPage,
    required this.onData,
    required this.interval,
    required this.alignment,
    required this.skipReloading,
    required this.reloadingBuilder,
    required this.errorBuilder,
    required this.loadingBuilder,
    required this.scrollLoadingBuilder,
    required this.scrollController,
  });

  final Future<List<T>> Function(int page) future;
  final AsyncPagedBuilder<T> builder;
  final List<T> initialData;
  final int initialPage;
  final ValueChanged<List<T>>? onData;
  final Duration? interval;
  final AlignmentGeometry? alignment;
  final bool skipReloading;
  final WidgetBuilder reloadingBuilder;
  final ErrorBuilder errorBuilder;
  final WidgetBuilder loadingBuilder;
  final WidgetBuilder scrollLoadingBuilder;
  final ScrollController scrollController;

  @override
  State<_AsyncPagedBuilder<T>> createState() => _AsyncPagedBuilderState<T>();
}

class _AsyncPagedBuilderState<T> extends State<_AsyncPagedBuilder<T>> {
  late final controller = widget.scrollController..addListener(scrollListener);
  final _results = <T>[];
  bool isLastPage = false;
  bool isScrollLoading = false;
  late int page = widget.initialPage;

  Future<void> scrollListener() async {
    final (pagedSearch, position) = (widget.future, controller.position);

    if (position.isAtMax && !isLastPage && !isScrollLoading) {
      setState(() => isScrollLoading = true);

      try {
        final list = await pagedSearch(++page);

        if (list.isEmpty) isLastPage = true;
        _results.addAll(list);
      } catch (e, s) {
        Async.errorLogger?.call(e, s);
      }

      setState(() => isScrollLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AsyncBuilder(
      future: () async {
        final data = await widget.future(page = widget.initialPage);
        _results.clear();
        _results.addAll(data);
        return data;
      },
      onData: widget.onData,
      interval: widget.interval,
      alignment: widget.alignment,
      initialData: widget.initialData,
      errorBuilder: widget.errorBuilder,
      skipReloading: widget.skipReloading,
      loadingBuilder: widget.loadingBuilder,
      reloadingBuilder: widget.reloadingBuilder,
      builder: (context, _) {
        return Column(
          children: [
            Expanded(child: widget.builder(context, controller, _results)),
            if (isScrollLoading) widget.scrollLoadingBuilder(context),
          ],
        );
      },
    );
  }
}

extension on ScrollPosition {
  bool get isAtMax {
    return pixels >= maxScrollExtent;
  }
}

///
extension FlutterAsyncSnapshotExtension<T> on AsyncSnapshot<T> {
  /// The error message of this [AsyncSnapshot.error].
  String? get errorMessage => hasError ? Async.message(error) : null;
}
