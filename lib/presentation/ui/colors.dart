import 'package:flutter/material.dart';


extension StyleColor on ColorScheme{


  Color get black => brightness == Brightness.light ? Color(0xFF000000) : Color(0xFF000000);
  Color get white => brightness == Brightness.light ? Color(0xFFFFFFFF) : Color(0xFFFFFFFF);


  Color get gray10 => brightness == Brightness.light ? Color(0xFFF9F9FB) : Color(0xFFF9F9FB);
  Color get gray20 => brightness == Brightness.light ? Color(0xFFE9EBEE) : Color(0xFFE9EBEE);
  Color get gray30 => brightness == Brightness.light ? Color(0xFFC5C8CE) : Color(0xFFC5C8CE);
  Color get gray40 => brightness == Brightness.light ? Color(0xFF949CA5) : Color(0xFF949CA5);
  Color get gray50 => brightness == Brightness.light ? Color(0xFF646F7C) : Color(0xFF646F7C);
  Color get gray60 => brightness == Brightness.light ? Color(0xFF374553) : Color(0xFF374553);
  Color get gray70 => brightness == Brightness.light ? Color(0xFF28323C) : Color(0xFF28323C);
  Color get gray80 => brightness == Brightness.light ? Color(0xFF101223) : Color(0xFF101223);

  Color get dim30 => brightness == Brightness.light ? gray80.withOpacity(0.3) : gray80.withOpacity(0.3);
  Color get dim50 => brightness == Brightness.light ? gray80.withOpacity(0.5) : gray80.withOpacity(0.5);
  Color get dim70 => brightness == Brightness.light ? gray80.withOpacity(0.8): gray80.withOpacity(0.8);


  Color get bg => brightness == Brightness.light ? Color(0xFFF3F1ED): Color(0xFFF3F1ED);
  Color get bg2 => brightness == Brightness.light ? Color(0xFFEBE5D9): Color(0xFFEBE5D9);

  Color get mainBlue => brightness == Brightness.light ? Color(0xFF4C6DEC): Color(0xFF4C6DEC);
  Color get mainYellow => brightness == Brightness.light ? Color(0xFFFFCE22): Color(0xFFFFCE22);

  Color get subGreen => brightness == Brightness.light ? Color(0xFF2E7E61): Color(0xFF2E7E61);
  Color get subOrange => brightness == Brightness.light ? Color(0xFFEB6532): Color(0xFFEB6532);
  Color get subRed => brightness == Brightness.light ? Color(0xFFD2301B): Color(0xFFD2301B);
  Color get subPaleBlue => brightness == Brightness.light ? Color(0xFF728FFF): Color(0xFF728FFF);
  Color get subBrown => brightness == Brightness.light ? Color(0xFFC8BEAC): Color(0xFFC8BEAC);



}