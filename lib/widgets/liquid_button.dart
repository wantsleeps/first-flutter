import 'package:flutter/material.dart';
import 'package:hello_flutter/utils/style.dart';

class LiquidButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double height;
  final bool isPrimary;

  const LiquidButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height = 50.0,
    this.isPrimary = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: isPrimary ? AppGradients.primaryGradient : null,
          color: isPrimary ? null : AppColors.glassWhite,
          borderRadius: BorderRadius.circular(30), // Pill shape
          boxShadow: [
            if (isPrimary)
              BoxShadow(
                color: AppColors.primary.withOpacity(0.4),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
          ],
          border: isPrimary ? null : Border.all(color: AppColors.glassBorder),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isPrimary ? Colors.white : AppColors.textBlack,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
