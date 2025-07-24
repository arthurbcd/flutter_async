import 'package:async_notifier/async_notifier.dart';
import 'package:flutter/material.dart';

import '../widgets/async/async.dart';

/// A [State] with an [AsyncNotifier].
abstract class AsyncState<T extends StatefulWidget, Data> extends State<T> {
  /// The [AsyncNotifier] of this state.
  @protected
  late final async = AsyncNotifier<Data>(data: initialData);

  /// The initial data of this state.
  Data? get initialData => null;

  /// The [AsyncSnapshot] of this state.
  AsyncSnapshot<Data> get snapshot => async.snapshot;

  /// Called whenever [AsyncSnapshot] changes.
  @mustCallSuper
  void onSnapshot(AsyncSnapshot<Data> snapshot) {
    snapshot.whenOrNull(error: Async.errorLogger);
  }

  @override
  void initState() {
    super.initState();
    async.addListener(() => setState(() => onSnapshot(snapshot)));
  }

  @override
  void dispose() {
    async.dispose();
    super.dispose();
  }
}
