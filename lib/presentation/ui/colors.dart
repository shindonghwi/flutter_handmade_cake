import 'package:flutter/material.dart';


extension StyleColor on ColorScheme{


  Color get black => brightness == Brightness.light ? Color(0xFF000000) : Color(0xFF000000);
  Color get white => brightness == Brightness.light ? Color(0xFFFFFFFF) : Color(0xFFFFFFFF);



  Color get colorPrimary900 => brightness == Brightness.light ? Color(0xFF01205F) : Color(0xFF01205F);

  Color get colorGray300 => brightness == Brightness.light ? Color(0xFFE1E1E1) : Color(0xFFE1E1E1);
  Color get colorGray500 => brightness == Brightness.light ? Color(0xFF999999) : Color(0xFF999999);

  Color get colorError500 => brightness == Brightness.light ? Color(0xFFEB5757) : Color(0xFFEB5757);



}