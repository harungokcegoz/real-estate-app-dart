import 'package:flutter/material.dart';

class AppColors {
  static const orange = Color(0xFFE65541);
  static const white = Color(0xFFFFFFFF);
  static const lightGray = Color(0xFFF7F7F7);
  static const darkGray = Color(0xFFEBEBEB);
  
  static const textStrong = Color(0xCC000000);
  static const textMedium = Color(0x66000000);
  static const textLight = Color(0x33000000);
}

class AppShadows {
  static const general = BoxShadow(
    color: Color(0x1A000000), // 10% opacity
    blurRadius: 8,
    offset: Offset(0, 2),
  );

  static const navigation = BoxShadow(
    color: Color(0x1A000000), // 10% opacity
    blurRadius: 8,
    offset: Offset(0, -2),
  );
}

class AppTypography {
  static const _baseTextStyle = TextStyle(
    fontFamily: 'GothamSSm',
  );

  static final title01 = _baseTextStyle.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w700, // Bold
  );
  
  static final title02 = _baseTextStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w700, // Bold
  );
  
  static final title03 = _baseTextStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w500, // Medium
  );
  
  static final body = _baseTextStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w400, // Book
  );
  
  static final input = _baseTextStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w300, // Light
  );
  
  static final hint = _baseTextStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w400, // Book
  );
  
  static final subtitle = _baseTextStyle.copyWith(
    fontSize: 10,
    fontWeight: FontWeight.w400, // Book
  );
  
  static final detail = _baseTextStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w400, // Book
  );
}

class CustomPadding {
  static const screen = EdgeInsets.symmetric(horizontal: 24, vertical: 10);
  static const horizontal = EdgeInsets.symmetric(horizontal: 20);
  static const vertical = EdgeInsets.symmetric(vertical: 20);
  static const all = EdgeInsets.all(20);
  static const onlyLeft = EdgeInsets.only(left: 20);
  static const onlyRight = EdgeInsets.only(right: 20);
  static const onlyTop = EdgeInsets.only(top: 20);
  static const onlyBottom = EdgeInsets.only(bottom: 20);
}
