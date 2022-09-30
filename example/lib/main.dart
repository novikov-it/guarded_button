import 'package:flutter/material.dart';
import 'package:guarded_button/guarded_button.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'Guarded Button Package Demo',
      home: GuardedButtonDemo(),
    ),
  );
}

class GuardedButtonDemo extends StatelessWidget {
  const GuardedButtonDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guarded Buttons Package Demo'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 120,
                    child: Text('Separate Guards:'),
                  ),
                  GuardedElevatedButton(
                    guard: Guard(),
                    onPressed: () => {},
                    onLongPress: () => {},
                    child: const Text('Elevated'),
                  ),
                  GuardedOutlinedButton(
                    guard: Guard(),
                    onPressed: () => {},
                    onLongPress: () => {},
                    child: const Text('Outlined'),
                  ),
                  GuardedTextButton(
                    guard: Guard(),
                    onPressed: () => {},
                    onLongPress: () => {},
                    child: const Text('Text'),
                  ),
                ].map((widget) => Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: widget,
                )).toList(),
              ),
              Builder(
                builder: (context) {
                  var guard = Guard();

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 120,
                        child: Text('Common Guard:'),
                      ),
                      GuardedElevatedButton(
                        guard: guard,
                        onPressed: () => {},
                        onLongPress: () => {},
                        child: const Text('Elevated'),
                      ),
                      GuardedOutlinedButton(
                        guard: guard,
                        onPressed: () => {},
                        onLongPress: () => {},
                        child: const Text('Outlined'),
                      ),
                      GuardedTextButton(
                        guard: guard,
                        onPressed: () => {},
                        onLongPress: () => {},
                        child: const Text('Text'),
                      ),
                    ].map((widget) => Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: widget,
                    )).toList(),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 120,
                    child: Text('Styled:'),
                  ),
                  GuardedElevatedButton(
                    guard: Guard(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () => {},
                    onLongPress: () => {},
                    child: const Text('Elevated'),
                  ),
                  GuardedOutlinedButton(
                    guard: Guard(),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () => {},
                    onLongPress: () => {},
                    child: const Text('Outlined'),
                  ),
                  GuardedTextButton(
                    guard: Guard(),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.orange,
                    ),
                    onPressed: () => {},
                    onLongPress: () => {},
                    child: const Text('Text'),
                  ),
                ].map((widget) => Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: widget,
                )).toList(),
              ),
            ].map((widget) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: widget,
            )).toList(),
          ),
        ),
      ),
    );
  }
}
