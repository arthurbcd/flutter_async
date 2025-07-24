import 'package:flutter/material.dart';
import 'package:flutter_async/flutter_async.dart';

void main() => runApp(
      const MaterialApp(
        home: Scaffold(
          body: _MyWidget(),
        ),
      ),
    );

class _MyWidget extends StatelessWidget {
  const _MyWidget();

  static const duration = Duration(seconds: 1);
  static const fabPadding = EdgeInsets.all(8);

  Future<void> onError() async {
    await Future<void>.delayed(duration);
    // ignore: strict_raw_type
    throw ParallelWaitError<List, List>([], [
      'Invalid user',
      'The email is already in use',
      'The password is too weak.',
    ]);
  }

  Future<void> onSuccess() async {
    await Future<void>.delayed(duration);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Column(
            children: [
              // AsyncBuilder(
              //   future: onError(), // or stream
              //   loadingBuilder: (context) {
              //     return const CircularProgressIndicator();
              //   },
              //   errorBuilder: (context, error, stackTrace) {
              //     return Text(error.toString());
              //   },
              //   builder: (context, data) {
              //     return const Text('data');
              //   },
              // ),

              AsyncButton(
                onPressed: onError,
                child: const FlutterLogo(size: 120),
                builder: (context, state, child) {
                  return InkWell(
                    // onTap: state.press,
                    child: child,
                  );
                },
              ),
              ElevatedButton(
                onPressed: onError,
                onLongPress: onSuccess,
                child: const Text('ElevatedButton'),
              ).asAsync(),
              ElevatedButton.icon(
                onPressed: onError,
                onLongPress: onSuccess,
                label: const Text('ElevatedButton.icon'),
                icon: const Icon(Icons.add),
              ).asAsync(),
              FilledButton(
                onPressed: onError,
                onLongPress: onSuccess,
                child: const Text('FilledButton'),
              ).asAsync(),
              FilledButton.icon(
                onPressed: onError,
                onLongPress: onSuccess,
                label: const Text('FilledButton.icon'),
                icon: const Icon(Icons.add),
              ).asAsync(),
              FilledButton.tonal(
                onPressed: onError,
                onLongPress: onSuccess,
                child: const Text('FilledButton.tonal'),
              ).asAsync(),
              FilledButton.tonalIcon(
                onPressed: onError,
                onLongPress: onSuccess,
                label: const Text('FilledButton.tonalIcon'),
                icon: const Icon(Icons.add),
              ).asAsync(),
              OutlinedButton(
                onPressed: onError,
                onLongPress: onSuccess,
                child: const Text('OutlinedButton'),
              ).asAsync(),
              OutlinedButton.icon(
                onPressed: onError,
                onLongPress: onSuccess,
                label: const Text('OutlinedButton.icon'),
                icon: const Icon(Icons.add),
              ).asAsync(),
              TextButton(
                onPressed: onError,
                onLongPress: onSuccess,
                child: const Text('TextButton'),
              ).asAsync(),
              TextButton.icon(
                onPressed: onError,
                onLongPress: onSuccess,
                label: const Text('TextButton.icon'),
                icon: const Icon(Icons.add),
              ).asAsync(),
            ].map((e) => Expanded(child: Center(child: e))).toList(),
          ),
          Column(
            children: [
              IconButton(
                key: AsyncKey('value_icon_button'),
                onPressed: onError,
                onLongPress: onSuccess,
                icon: const Icon(Icons.add),
              ).asAsync(),
              IconButton.filled(
                onPressed: onSuccess,
                onLongPress: onError,
                icon: const Icon(Icons.add),
              ).asAsync(successIcon: const Icon(Icons.check)),
              IconButton.filledTonal(
                onPressed: onError,
                onLongPress: onSuccess,
                icon: const Icon(Icons.add),
              ).asAsync(),
              IconButton.outlined(
                onPressed: onSuccess,
                onLongPress: onError,
                icon: const Icon(Icons.add),
              ).asAsync(),
            ],
          ),
          SizedBox(
            height: 400,
            width: 400,
            child: AsyncBuilder.paged(
              future: (page) async {
                await Future<void>.delayed(duration);
                return List.generate(10, (i) => 'Patient ${page * 10 + i}');
              },
              builder: (context, controller, list) {
                return ListView.builder(
                  controller: controller,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return ListTile(title: Text(list[index]));
                  },
                );
              },
            ),
          ),
        ],
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
              onPressed: () async {
                await AsyncKey('value_icon_button').currentButton?.press();
              },
              child: const Icon(Icons.add),
            ).asAsync(),
          ].map((e) => Padding(padding: fabPadding, child: e)).toList(),
        ),
      ),
    );
  }
}
