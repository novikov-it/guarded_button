/// @nodoc

import 'package:flutter/foundation.dart';

/// [Guard] restricts interaction with button until both asynchronous request is
/// completed and [minProcessingTime] has passed.
///
/// [Guard] can be shared
/// between several buttons to restrict interaction with all of them at once.
///
/// [Guard] can also be listened externally, notifying when request is completed
class Guard with ChangeNotifier {
  /// Minimum time for [Guard] to lock button.
  ///
  /// It is recommended to set this to [Duration.zero] if it becomes
  /// impossible to interact with button when async request is completed, e.g.
  /// when button disappears after request.
  ///
  /// Defaults to 300 milliseconds
  final Duration minProcessingTime;

  Guard({this.minProcessingTime = const Duration(milliseconds: 300)});

  bool _processing = false;

  bool get isProcessing => _processing;

  /// Starts processing of the [Guard], notifying all listeners.
  /// Processing won't start if it is already active.
  ///
  /// By default, [process] is called whenever button is pressed or long
  /// pressed, if these actions are defined. However, one can call this method
  /// externally, thus disabling listening buttons.
  void process(Function()? onPressed) async {
    if (onPressed != null && _startProcessing()) {
      await Future.wait(
          [Future.value(onPressed()), Future.delayed(minProcessingTime)]);
      _endProcessing();
    }
  }

  bool _startProcessing() {
    if (_processing == false) {
      _processing = true;
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  void _endProcessing() {
    _processing = false;
    notifyListeners();
  }
}
