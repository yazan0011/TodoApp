import 'package:flutter/material.dart';
import 'package:todoapp/utils/constants.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color color;
  final double borderRadius;
  final double height;
  final TextStyle? textStyle;

  const CustomElevatedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.color = AppColors.primary,
    this.borderRadius = 30.0,
    this.height = 50.0,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        minimumSize: Size(double.infinity, height),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: textStyle ??
            const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
