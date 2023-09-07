import 'package:flutter/material.dart';

import '../theme/utils/my_colors.dart';

class MyGlobalContainerWidget extends StatelessWidget {
  const MyGlobalContainerWidget({
    super.key,
    this.child,
    this.color = MyColors.blue,
    this.isSelected = false,
    this.alignment = Alignment.center,
    this.height = 40,
  });

  final Widget? child;
  final bool? isSelected;
  final Color color;
  final double? height;
  final AlignmentGeometry? alignment;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: isSelected == true
            ? null
            : Border.all(width: 0.5, color: Colors.grey[400]!),
        borderRadius: BorderRadius.circular(8),
        color: color,
        boxShadow: isSelected == true
            ? [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 5,
                  spreadRadius: 2,
                  offset: const Offset(0, 8),
                ),
                BoxShadow(
                  color: color.withOpacity(0.5),
                  blurRadius: 5,
                  offset: const Offset(0, 0),
                ),
              ]
            : [],
      ),
      child: child,
    );
  }
}
