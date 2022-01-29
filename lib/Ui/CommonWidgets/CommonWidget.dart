import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double? width;
  final double? height;
  final double? elevation;
  final VoidCallback? onTap;
  final Gradient? gradient;
  final Color? color;
  final Color? shadowColor;
  final BorderRadiusGeometry? borderRadius;
  final BorderRadius? shadowRadius;
  final Widget? child;
  CustomButton({
    this.height,
    this.width,
    this.onTap,
    this.gradient,
    this.color,
    this.borderRadius,
    this.child,
    this.elevation,
    this.shadowRadius,
    this.shadowColor,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: PhysicalModel(
        color: Colors.transparent,
        elevation: elevation ?? 5,
        shadowColor: shadowColor ?? Colors.grey,
        borderRadius: shadowRadius ?? BorderRadius.circular(5),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              gradient: gradient, color: color, borderRadius: borderRadius),
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Snackbar

const Color bgColor = Color(0xFF0044CE);
const Color uploadColor = Color(0xff0F0F2D);

class CustomSnackBar {
  CustomSnackBar(BuildContext context, Widget content,
      {SnackBarAction? snackBarAction, Color backgroundColor = bgColor}) {
    final SnackBar snackBar = SnackBar(
        action: snackBarAction,
        backgroundColor: backgroundColor,
        content: content,
        behavior: SnackBarBehavior.floating);

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
