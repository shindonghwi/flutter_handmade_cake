import 'package:flutter/material.dart';


extension StyleColor on ColorScheme{


  Color get black => brightness == Brightness.light ? const Color(0xFF000000) : const Color(0xFF000000);
  Color get white => brightness == Brightness.light ? const Color(0xFFFFFFFF) : const Color(0xFFFFFFFF);



  Color get colorPrimary500 => brightness == Brightness.light ? const Color(0xFF01205F) : const Color(0xFF01205F);

  Color get colorGray100 => brightness == Brightness.light ? const Color(0xFFF5F5F5) : const Color(0xFFF5F5F5);
  Color get colorGray200 => brightness == Brightness.light ? const Color(0xFFE9E9E9) : const Color(0xFFE9E9E9);
  Color get colorGray300 => brightness == Brightness.light ? const Color(0xFFE1E1E1) : const Color(0xFFE1E1E1);
  Color get colorGray500 => brightness == Brightness.light ? const Color(0xFF999999) : const Color(0xFF999999);
  Color get colorGray800 => brightness == Brightness.light ? const Color(0xFF3F3F3F) : const Color(0xFF3F3F3F);

  Color get colorError500 => brightness == Brightness.light ? const Color(0xFFEB5757) : const Color(0xFFEB5757);



}