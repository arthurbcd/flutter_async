import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_async/flutter_async.dart';
import 'package:flutter_test/flutter_test.dart';

class T {
  const T(this.value);
  final int value;
}

void main() {
  test('AsyncNotifier.value', () {
    int? data = 0;
    final n = AsyncNotifier<int?>(0, onData: (d) => data = d);
    expect(data, 0);
    expect(n.value, 0);
    expect(n.snapshot, AsyncSnapshot.withData(ConnectionState.none, data));

    n.value = 1;
    expect(data, 1);
    expect(n.value, 1);
    expect(n.snapshot, AsyncSnapshot.withData(ConnectionState.none, data));

    n.value = null;
    expect(data, null);
    expect(n.value, null);
    expect(n.snapshot, const AsyncSnapshot.nothing());
  });

  group('AsyncNotifier.future', () {
    int? data;
    final n = AsyncNotifier<int?>(null, onData: (d) => data = d);
    test('ConnectionState.none', () async {
      expect(data, null);
      expect(n.value, null);
      expect(n.isLoading, false);
      expect(n.snapshot, const AsyncSnapshot.nothing());
    });

    test('ConnectionState.waiting', () async {
      n.future = Future.delayed(const Duration(milliseconds: 100), () => 1);
      expect(data, null);
      expect(n.value, null);
      expect(n.isLoading, true);
      expect(n.snapshot, const AsyncSnapshot.waiting());
    });

    test('ConnectionState.done', () async {
      await Future.delayed(const Duration(milliseconds: 200));
      expect(data, 1);
      expect(n.value, 1);
      expect(n.snapshot, AsyncSnapshot.withData(ConnectionState.done, data));
    });
  });

  test('AsyncNotifier.future with error', () async {
    final e = Object();
    bool? data;
    Object? error;
    StackTrace? stackTrace;

    final n = AsyncNotifier<bool?>(
      null,
      onData: (d) => data = d,
      onError: (e, s) {
        error = e;
        stackTrace = s;
      },
    );

    n.future = Future.delayed(const Duration(seconds: 1), () => throw e);
    expect(data, null);
    expect(n.value, null);
    expect(n.isLoading, true);
    expect(n.hasError, false);
    expect(n.error, null);
    expect(n.connectionState, ConnectionState.waiting);
    expect(n.snapshot, const AsyncSnapshot.waiting());

    await Future.delayed(const Duration(seconds: 1));
    expect(data, null);
    expect(n.value, null);
    expect(n.isLoading, false);
    expect(n.hasError, true);
    expect(n.error, error);
    expect(n.connectionState, ConnectionState.done);

    final snapshotWithError = AsyncSnapshot<bool?>.withError(
      ConnectionState.done,
      error!,
      stackTrace!,
    );
    expect(n.snapshot, snapshotWithError);
  });

  test('AsyncNotifier.future with new future', () async {
    int? data;
    final n = AsyncNotifier<int?>(null, onData: (d) => data = d);

    // First future.
    n.future = Future.delayed(const Duration(milliseconds: 100), () => 1);
    expect(data, null);
    expect(n.value, null);
    expect(n.isLoading, true);
    expect(n.snapshot, const AsyncSnapshot.waiting());

    // Second future.
    n.future = Future.delayed(const Duration(milliseconds: 200), () => 2);
    expect(data, null);
    expect(n.value, null);
    expect(n.isLoading, true);
    expect(n.snapshot, const AsyncSnapshot.waiting());

    // First future has no time to complete. It's overriden by second future.
    await Future.delayed(const Duration(milliseconds: 150));
    expect(data, isNot(1));
    expect(n.value, isNot(1));
    expect(n.isLoading, true);
    expect(n.snapshot, const AsyncSnapshot.waiting());

    // Second future completes normally.
    await Future.delayed(const Duration(milliseconds: 200));
    expect(data, 2);
    expect(n.value, 2);
    expect(n.isLoading, false);
    expect(n.snapshot, AsyncSnapshot.withData(ConnectionState.done, data));
  });

  group('AsyncNotifier.stream', () {
    int? data;
    final n = AsyncNotifier<int?>(null, onData: (d) => data = d);
    test('ConnectionState.none', () async {
      expect(data, null);
      expect(n.value, null);
      expect(n.isLoading, false);
      expect(n.snapshot, const AsyncSnapshot.nothing());
    });

    test('ConnectionState.waiting', () async {
      /// will stream 0, 1, 2
      n.stream = Stream.periodic(const Duration(seconds: 1), (i) => i).take(3);
      expect(data, null);
      expect(n.value, null);
      expect(n.isLoading, true);
      expect(n.snapshot, const AsyncSnapshot.waiting());
    });

    test('ConnectionState.active', () async {
      await Future.delayed(const Duration(seconds: 2));
      expect(data, 1);
      expect(n.value, 1);
      expect(n.snapshot, AsyncSnapshot.withData(ConnectionState.active, data));
    });

    test('ConnectionState.done', () async {
      await Future.delayed(const Duration(seconds: 3));
      expect(data, 2);
      expect(n.value, 2);
      expect(n.snapshot, AsyncSnapshot.withData(ConnectionState.done, data));
    });
  });

  test('AsyncNotifier.stream with error', () async {
    final e = Object();
    int? data;
    Object? error;
    StackTrace? stackTrace;
    final controller = StreamController<int>();

    final n = AsyncNotifier<int?>(
      null,
      onData: (d) => data = d,
      onError: (e, s) {
        error = e;
        stackTrace = s;
      },
    );

    n.stream = controller.stream;

    expect(data, null);
    expect(n.value, null);
    expect(n.isLoading, true);
    expect(n.hasError, false);
    expect(n.error, null);
    expect(n.connectionState, ConnectionState.waiting);
    expect(n.snapshot, const AsyncSnapshot.waiting());

    controller.add(1);
    await Future.delayed(const Duration(seconds: 1));

    expect(data, 1);
    expect(n.value, 1);
    expect(n.isReloading, true);
    expect(n.hasError, false);
    expect(n.error, null);
    expect(n.connectionState, ConnectionState.active);
    expect(n.snapshot, AsyncSnapshot.withData(ConnectionState.active, data));

    controller.addError(e);
    await Future.delayed(const Duration(seconds: 1));

    expect(data, 1);
    expect(n.value, 1);
    expect(n.isLoading, false);
    expect(n.hasError, true);
    expect(n.error, error);
    expect(n.connectionState, ConnectionState.active);

    final snapshotWithError = AsyncSnapshot<int?>.withError(
      ConnectionState.active,
      error!,
      stackTrace!,
    );
    expect(n.snapshot, snapshotWithError);

    controller.add(2);
    controller.close();
    await Future.delayed(const Duration(seconds: 1));

    expect(data, 2);
    expect(n.value, 2);
    expect(n.isLoading, false);
    expect(n.hasError, false);
    expect(n.error, null);
    expect(n.connectionState, ConnectionState.done);
    expect(n.snapshot, AsyncSnapshot.withData(ConnectionState.done, data));
  });

  test('AsyncNotifier.stream with new stream', () async {
    int? data;
    final completer = Completer<void>();

    final n = AsyncNotifier<int?>(
      null,
      onData: (d) => data = d,
      onError: (error, stackTrace) {
        completer.complete();
      },
    );

    // First stream.
    n.stream = Stream.periodic(const Duration(seconds: 1), (_) => throw -1);
    expect(data, null);
    expect(n.value, null);
    expect(n.isLoading, true);
    expect(n.snapshot, const AsyncSnapshot.waiting());

    // Second stream.
    n.stream = Stream.periodic(const Duration(seconds: 1), (i) => 1).take(1);
    expect(data, null);
    expect(n.value, null);
    expect(n.isLoading, true);
    expect(n.snapshot, const AsyncSnapshot.waiting());

    // First stream has no time to throw. It's overriden by second stream.
    await Future.delayed(const Duration(seconds: 1));
    expect(data, 1);
    expect(n.value, 1);
    expect(n.error, isNot(-1));
    expect(n.hasError, false);
    expect(n.isLoading, false);
    expect(n.isReloading, true);
    expect(n.snapshot, AsyncSnapshot.withData(ConnectionState.active, data));

    await Future.delayed(const Duration(seconds: 1));
    expect(n.snapshot, AsyncSnapshot.withData(ConnectionState.done, data));

    // Error never called.
    expect(completer.isCompleted, false);
  });
}
