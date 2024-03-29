import 'package:flutter/material.dart';
import 'package:flutter_async/flutter_async.dart';

void main() => runApp(
      MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.light,
          ),
        ),
        home: const Scaffold(
          body: MyWidget(),
        ),
      ),
    );

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  static const duration = Duration(seconds: 1);
  static const fabPadding = EdgeInsets.all(8);

  Future<void> onError() async {
    await Future.delayed(duration);
    throw 'Some error message';
  }

  Future<void> onSuccess() async {
    await Future.delayed(duration);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AsyncBuilder(
            future: onError(), // or stream
            loadingBuilder: (context) {
              return const CircularProgressIndicator();
            },
            errorBuilder: (context, error, stackTrace) {
              return Text(error.toString());
            },
            builder: (context, data) {
              return const Text('data');
            },
          ),
          AsyncButtonBuilder(
            onPressed: onError,
            child: const FlutterLogo(size: 120),
            builder: (context, state, child) {
              return InkWell(
                onTap: state.press,
                child: child,
              );
            },
          ),
          ElevatedButton(
            onPressed: onError,
            child: const Text('ElevatedButton'),
          ).asAsync(),
          ElevatedButton.icon(
            onPressed: onError,
            label: const Text('ElevatedButton.icon'),
            icon: const Icon(Icons.add),
          ).asAsync(),
          FilledButton(
            onPressed: onError,
            child: const Text('FilledButton'),
          ).asAsync(),
          FilledButton.icon(
            onPressed: onError,
            label: const Text('FilledButton.icon'),
            icon: const Icon(Icons.add),
          ).asAsync(),
          FilledButton.tonal(
            onPressed: onError,
            child: const Text('FilledButton.tonal'),
          ).asAsync(),
          FilledButton.tonalIcon(
            onPressed: onError,
            label: const Text('FilledButton.tonalIcon'),
            icon: const Icon(Icons.add),
          ).asAsync(),
          OutlinedButton(
            onPressed: onError,
            child: const Text('OutlinedButton'),
          ).asAsync(),
          OutlinedButton.icon(
            onPressed: onError,
            label: const Text('OutlinedButton.icon'),
            icon: const Icon(Icons.add),
          ).asAsync(),
          TextButton(
            onPressed: onError,
            child: const Text('TextButton'),
          ).asAsync(),
          TextButton.icon(
            onPressed: onError,
            label: const Text('TextButton.icon'),
            icon: const Icon(Icons.add),
          ).asAsync(),
        ].map((e) => Expanded(child: Center(child: e))).toList(),
      ),

      // Use Async to scope an [AsyncConfig] to its descendants.
      floatingActionButton: Async(
        config: AsyncConfig(
          buttonConfig: AsyncButtonConfig.icon(
            successIcon: const Icon(Icons.check),
            successColor: Colors.green,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton.small(
              onPressed: onSuccess,
              child: const Icon(Icons.add),
            ).asAsync(),
            FloatingActionButton(
              onPressed: onSuccess,
              isExtended: true,
              child: const Icon(Icons.add),
            ).asAsync(),
            FloatingActionButton.extended(
              onPressed: onSuccess,
              icon: const Icon(Icons.add),
              label: const Text('extended'),
            ).asAsync(),
            FloatingActionButton.large(
              onPressed: onSuccess,
              child: const Icon(Icons.add),
            ).asAsync(),
          ].map((e) => Padding(padding: fabPadding, child: e)).toList(),
        ),
      ),
    );
  }
}
