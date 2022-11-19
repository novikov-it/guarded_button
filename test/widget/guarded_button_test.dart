import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guarded_button/guarded_button.dart';

Widget buildTestedWidget({
  bool createGuards = true,
  Guard? guard,
  ButtonStyle? style,
}) {
  return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        children: [
          GuardedElevatedButton(
            guard: createGuards ? Guard() : guard,
            onPressed: () {},
            onLongPress: () {},
            child: const Text('Button'),
            style: style,
          ),
          GuardedOutlinedButton(
            guard: createGuards ? Guard() : guard,
            onPressed: () {},
            onLongPress: () {},
            child: const Text('Button'),
            style: style,
          ),
          GuardedTextButton(
            guard: createGuards ? Guard() : guard,
            onPressed: () {},
            onLongPress: () {},
            child: const Text('Button'),
            style: style,
          ),
        ],
      ));
}

void main() {
  group('Guarded buttons', () {
    late List<Finder> buttonFinders;
    late Finder progressIndicatorFinder;
    late List<Function(WidgetTester, Finder)> actions;

    setUpAll(() {
      buttonFinders = [
        find.byType(GuardedElevatedButton),
        find.byType(GuardedOutlinedButton),
        find.byType(GuardedTextButton),
      ];

      progressIndicatorFinder = find.bySubtype<ProgressIndicator>();

      actions = [
        (WidgetTester tester, Finder finder) => tester.tap(finder),
        (WidgetTester tester, Finder finder) => tester.longPress(finder),
      ];
    });

    testWidgets('Guarded buttons of all types should render', (tester) async {
      await tester.pumpWidget(buildTestedWidget(createGuards: true));

      var buttonsFinder = find.bySubtype<ButtonStyleButton>();

      expect(buttonsFinder, findsNWidgets(3));

      for (Finder finder in buttonFinders) {
        expect(finder, findsOneWidget);
      }
    });

    testWidgets(
        'Guarded buttons should independently show ProgressIndicator on tap and long press',
        (tester) async {
      await tester.pumpWidget(buildTestedWidget(createGuards: true));

      for (var action in actions) {
        for (Finder finder in buttonFinders) {
          var descendantProgressFinder = find.descendant(
            of: finder,
            matching: progressIndicatorFinder,
          );

          await action(tester, finder);
          await tester.pump(Duration(milliseconds: 100));

          expect(progressIndicatorFinder, findsOneWidget);
          expect(descendantProgressFinder, findsOneWidget);

          await tester.pump(Duration(milliseconds: 200));

          expect(progressIndicatorFinder, findsNothing);
          expect(descendantProgressFinder, findsNothing);
        }
      }
    });

    testWidgets(
        'Guarded buttons with common Guard should all show ProgressIndicator on tap and long press',
        (tester) async {
      await tester
          .pumpWidget(buildTestedWidget(createGuards: false, guard: Guard()));

      for (var action in actions) {
        for (Finder finder in buttonFinders) {
          await action(tester, finder);
          await tester.pump(Duration(milliseconds: 100));

          expect(progressIndicatorFinder, findsNWidgets(3));

          for (Finder buttonFinder in buttonFinders) {
            var descendantProgressFinder = find.descendant(
              of: buttonFinder,
              matching: progressIndicatorFinder,
            );

            expect(descendantProgressFinder, findsOneWidget);
          }

          await tester.pump(Duration(milliseconds: 200));

          expect(progressIndicatorFinder, findsNothing);
        }
      }
    });

    testWidgets('Guarded button should not reset timer after second action',
        (tester) async {
      await tester.pumpWidget(buildTestedWidget(createGuards: true));

      for (var action in actions) {
        for (Finder finder in buttonFinders) {
          await action(tester, finder);
          await tester.pump(Duration(milliseconds: 100));

          expect(progressIndicatorFinder, findsOneWidget);

          await action(tester, finder);
          await tester.pump(Duration(milliseconds: 200));

          expect(progressIndicatorFinder, findsNothing);
        }
      }
    });

    testWidgets(
        'Progress indicator should be colored in style foreground color',
        (tester) async {
      final ButtonStyle style = ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
      );

      await tester.pumpWidget(
        buildTestedWidget(createGuards: true, style: style),
      );

      var progressIndicatorFinder = find.bySubtype<ProgressIndicator>();

      for (var action in actions) {
        for (Finder finder in buttonFinders) {
          await action(tester, finder);
          await tester.pump(Duration(milliseconds: 100));

          var descendantProgressFinder = find.descendant(
            of: finder,
            matching: progressIndicatorFinder,
          );

          var progressIndicator =
              tester.widget<ProgressIndicator>(descendantProgressFinder);

          expect(progressIndicator.color,
              style.foregroundColor?.resolve(<MaterialState>{}));

          await tester.pump(Duration(milliseconds: 200));
        }
      }
    });
  });
}
