// lib/app_styles.dart
import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppStyles {
  static final BoxDecoration inputDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [AppColors.primaryColor1, AppColors.primaryColor2],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(30.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        spreadRadius: 2,
        blurRadius: 8,
        offset: Offset(2, 4),
      ),
      BoxShadow(
        color: AppColors.glowColor.withOpacity(0.6),
        spreadRadius: 4,
        blurRadius: 10,
        offset: Offset(0, 0),
      ),
    ],
    border: Border.all(
      width: 2,
      color: AppColors.primaryColor2,
    ),
  );

  static final BoxDecoration buttonDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [AppColors.buttonColor1, AppColors.buttonColor2],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(30.0),
  );

  static final InputDecoration textFieldInputDecoration = InputDecoration(
    filled: true,
    fillColor: Colors.transparent,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.0),
      borderSide: BorderSide.none,
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 20),
  );
}
