import 'package:flutter/material.dart';

class MyGlobalElevatedButtonWidget extends StatelessWidget {
  const MyGlobalElevatedButtonWidget({
    super.key,
    this.onPressed,
    required this.side,
    this.backgroundColor,
    required this.child,
  });
  final void Function()? onPressed;
  final BorderSide side;
  final Color? backgroundColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 46,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          foregroundColor: Colors.white,
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: side,
          ),
        ),
        child: child,
      ),
    );
  }
}
