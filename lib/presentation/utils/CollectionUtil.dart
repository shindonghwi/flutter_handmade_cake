import 'package:flutter/cupertino.dart';

class CollectionUtil{

  static bool isNullEmptyFromString(String? data){
    if (data == null || data.isEmpty) {
      return true;
    }
    return false;
  }

  static bool isNullorEmpty(List<dynamic>? items){
    if (items == null || items.isEmpty) {
      return true;
    }
    return false;
  }

  static List<int> fillWithNegatives(List<int> input, int maxLength) {
    List<int> output = List<int>.filled(maxLength, -1);
    for (int i = 0; i < input.length; i++) {
      if (input.contains(i)){
        output[i] = input[i];
      }
    }

    return output;
  }

  static bool isEqualLowerCase(String str1, String str2){
    return str1.toLowerCase() == str2.toLowerCase();
  }


}