import 'dart:ui';
import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF6A11CB); // Deep Purple
  static const Color secondary = Color(0xFF2575FC); // Vibrant Blue
  static const Color accent = Color(0xFF00F260); // Neon Green
  static const Color backgroundStart = Color(0xFFE0EAFC);
  static const Color backgroundEnd = Color(0xFFCFDEF3);

  static const Color glassWhite = Color(0x33FFFFFF); // 20% White
  static const Color glassWhiteHigh = Color(0x66FFFFFF); // 40% White
  static const Color glassBorder = Color(0x4DFFFFFF); // 30% White

  static const Color textBlack = Color(0xFF1D1D1F);
  static const Color textGrey = Color(0xFF86868B);
}

class AppGradients {
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [AppColors.primary, AppColors.secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient liquidMesh = LinearGradient(
    colors: [Color(0xFF8EC5FC), Color(0xFFE0C3FC), Color(0xFFFFFFFF)],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient glassBorderGradient = LinearGradient(
    colors: [Colors.white60, Colors.white10],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient waterDrop = LinearGradient(
    colors: [Color(0xFF89F7FE), Color(0xFF66A6FF)], // Fresh Water: Cyan to Blue
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class AppTextStyles {
  static const TextStyle header = TextStyle(
    fontFamily: 'SF Pro Display', // Assuming system font or asset
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textBlack,
    letterSpacing: -0.5,
  );

  static const TextStyle subHeader = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textBlack,
  );

  static const TextStyle body = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 16,
    color: AppColors.textBlack,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 14,
    color: AppColors.textGrey,
  );
}

class Glassdecoration extends BoxDecoration {
  Glassdecoration({
    double radius = 20,
    Color color = AppColors.glassWhite,
    Color borderColor = AppColors.glassBorder,
  }) : super(
         color: color,
         borderRadius: BorderRadius.circular(radius),
         border: Border.all(color: borderColor, width: 1.5),
         boxShadow: [
           BoxShadow(
             color: Colors.black.withOpacity(0.05),
             blurRadius: 20,
             offset: const Offset(0, 10),
           ),
         ],
       );
}
