import 'package:flutter/material.dart';

class MyGlobalElevatedButtonWidget extends StatelessWidget {
  const MyGlobalElevatedButtonWidget({
    super.key,
    this.onPressed,
    required this.side,
    this.backgroundColor,
    required this.child,
    this.elevation = 0.5,
  });
  final void Function()? onPressed;
  final BorderSide side;
  final Color? backgroundColor;
  final Widget? child;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 46,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: elevation,
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
