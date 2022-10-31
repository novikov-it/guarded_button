# Guarded Button

A Flutter package that adds Material buttons with guards that restrict user interaction.

A button with Guard displays ```CircularProgressIndicator``` until the moment async callback ends or minimum time passes. The minimum time can be set in Guard constructor.

At the moment package works with Elevated, Outlined and Text buttons. 

---

You can add separate Guards to make each button work independently:

![SeparateGuards](https://user-images.githubusercontent.com/45228733/198983483-7263358b-0b4b-43bc-b396-abf6f0d35011.gif)

```dart
[
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
]
```

You can use one Guard for several buttons to restrict interaction with all of them whenever one is pressed:

![CommonGuard](https://user-images.githubusercontent.com/45228733/198983577-ec214e97-50a7-44fe-9a04-a3d73a7e7103.gif)

```dart
[
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
]
```

Styling buttons is supported:

![StyledButtons](https://user-images.githubusercontent.com/45228733/198983602-caff4c29-4d37-4682-9e72-f1009864dfca.gif)

```dart
[
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
]
```
