/// @nodoc

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'guard.dart';

class GuardedButtonChild extends StatefulWidget {
  final Color? progressColor;
  final Guard? guard;
  final Widget? child;

  const GuardedButtonChild({
    super.key,
    required this.child,
    this.progressColor,
    this.guard,
  });

  @override
  State<GuardedButtonChild> createState() => _State();
}

class _State extends State<GuardedButtonChild> {
  late double buttonChildWidth;
  late double buttonChildHeight;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: widget.guard,
      builder: (context, _) {
        if (widget.guard != null && context.watch<Guard>().isProcessing) {
          return Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: buttonChildWidth,
                height: buttonChildHeight,
              ),
              SizedBox(
                  width: buttonChildHeight * 0.75,
                  height: buttonChildHeight * 0.75,
                  child: CircularProgressIndicator(
                    color: widget.progressColor,
                  )),
            ],
          );
        }

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            buttonChildWidth = context.size!.width;
            buttonChildHeight = context.size!.height;
          }
        });

        if (widget.child == null) return Container();

        return widget.child!;
      },
    );
  }
}
