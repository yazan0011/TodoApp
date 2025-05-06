import 'package:flutter/material.dart';

void showCustomAnimatedDialog(BuildContext context, {required Widget child}) {
  showGeneralDialog(
    context: context,
    barrierLabel: "Dialog",
    barrierDismissible: true,
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (context, animation, secondaryAnimation) =>
        Center(child: child),
    transitionBuilder: (context, animation, secondaryAnimation, widget) {
      return ScaleTransition(
        scale: CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOutBack,
        ),
        child: Opacity(
          opacity: animation.value,
          child: widget,
        ),
      );
    },
  );
}
