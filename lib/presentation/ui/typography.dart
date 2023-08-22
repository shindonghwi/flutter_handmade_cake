import 'package:flutter/material.dart';

/**
 * @feature: TextStyle 을 정의한 파일
 *
 * @author: 2023/02/07 5:49 PM donghwishin
 *
 * @description{
 *    color, underline 등 기능은 사용할때 custom 하여 사용한다.
 * }
 */
const defaultTextStyle = TextStyle(
  fontFamily: 'Pretendard',
  overflow: TextOverflow.ellipsis,
  letterSpacing: 0,
);

extension StyleText on TextTheme {
  TextStyle get h1_B => defaultTextStyle.copyWith(
      fontSize: 26,
      fontWeight: FontWeight.w700,
      height: 1.34
  );
  TextStyle get h1_R => defaultTextStyle.copyWith(
      fontSize: 26,
      fontWeight: FontWeight.w400,
      height: 1.34
  );
   TextStyle get h2_B => defaultTextStyle.copyWith(
      fontSize: 22,
      fontWeight: FontWeight.w700,
       height: 1.36
  );
  TextStyle get h2_R=> defaultTextStyle.copyWith(
      fontSize: 22,
      fontWeight: FontWeight.w400,
      height: 1.36
  );
   TextStyle get h3_B=> defaultTextStyle.copyWith(
      fontSize: 18,
      fontWeight: FontWeight.w700,
       height: 1.44
  );
  TextStyle get h3_R=> defaultTextStyle.copyWith(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      height: 1.44
  );
   TextStyle get b1_B=> defaultTextStyle.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w700,
       height: 1.43
  );
  TextStyle get b1_R=> defaultTextStyle.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.43
  );
   TextStyle get b2_B=> defaultTextStyle.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w700,
       height: 1.42
  );
  TextStyle get b2_R=> defaultTextStyle.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.42
  );
   TextStyle get c1_B=> defaultTextStyle.copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w700,
       height: 1.41
  );
  TextStyle get c1_R=> defaultTextStyle.copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 1.41
  );

}
