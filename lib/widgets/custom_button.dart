// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:budget_tracker/widgets/colors.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double borderRadius;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final Icon? prefixIcon;
  const CustomButton({
    Key? key,
    required this.child,
    this.color,
    this.borderRadius = 12.0,
    required this.onPressed,
    this.width = double.infinity,
    this.height = 50,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        primary: color ?? AppColors.secondaryColor,
      ),
    );
  }
}
