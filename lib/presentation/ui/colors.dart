import 'package:flutter/material.dart';


extension StyleColor on ColorScheme{


  Color get black => brightness == Brightness.light ? Color(0xFF000000) : Color(0xFF000000);
  Color get white => brightness == Brightness.light ? Color(0xFFFFFFFF) : Color(0xFFFFFFFF);




  Color get colorPrimary900 => brightness == Brightness.light ? Color(0xFF01205F) : Color(0xFF01205F);



}