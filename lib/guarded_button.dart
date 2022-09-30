/// Adds Material buttons with guards
library guarded_button;

import 'package:flutter/material.dart';

import 'src/guard.dart';
import 'src/guarded_button_child.dart';

export 'src/guard.dart';

/// An [ElevatedButton] with [Guard]
///
/// For more information on how guarded buttons work, see [Guard]
class GuardedElevatedButton extends ElevatedButton {
  GuardedElevatedButton({
    required VoidCallback? onPressed,
    required Widget? child,
    Guard? guard,
    VoidCallback? onLongPress,
    super.key,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    super.autofocus,
    super.clipBehavior,
    super.statesController,
  }) : super(
          onPressed: onPressed != null
              ? guard == null
                  ? onPressed
                  : () => guard.process(onPressed)
              : null,
          onLongPress: onLongPress != null
              ? guard == null
                  ? onLongPress
                  : () => guard.process(onPressed)
              : null,
          child: GuardedButtonChild(
            progressColor: style?.foregroundColor?.resolve({}) ?? Colors.white,
            guard: guard,
            child: child,
          ),
        );
}

/// An [OutlinedButton] with [Guard]
class GuardedOutlinedButton extends OutlinedButton {
  GuardedOutlinedButton({
    required VoidCallback? onPressed,
    required Widget? child,
    Guard? guard,
    VoidCallback? onLongPress,
    super.key,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    super.autofocus,
    super.clipBehavior,
    super.statesController,
  }) : super(
          onPressed: onPressed != null
              ? guard == null
                  ? onPressed
                  : () => guard.process(onPressed)
              : null,
          onLongPress: onLongPress != null
              ? guard == null
                  ? onLongPress
                  : () => guard.process(onPressed)
              : null,
          child: GuardedButtonChild(
            progressColor: style?.foregroundColor?.resolve({}),
            guard: guard,
            child: child,
          ),
        );
}

/// A [TextButton] with [Guard]
class GuardedTextButton extends TextButton {
  GuardedTextButton({
    required VoidCallback? onPressed,
    required Widget? child,
    Guard? guard,
    VoidCallback? onLongPress,
    super.key,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    super.autofocus,
    super.clipBehavior,
    super.statesController,
  }) : super(
          onPressed: onPressed != null
              ? guard == null
                  ? onPressed
                  : () => guard.process(onPressed)
              : null,
          onLongPress: onLongPress != null
              ? guard == null
                  ? onLongPress
                  : () => guard.process(onPressed)
              : null,
          child: GuardedButtonChild(
            progressColor: style?.foregroundColor?.resolve({}),
            guard: guard,
            child: child,
          ),
        );
}
