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
  TextStyle get thin => defaultTextStyle.copyWith(
      fontWeight: FontWeight.w100,
  );
  TextStyle get extraLight => defaultTextStyle.copyWith(
      fontWeight: FontWeight.w200,
  );

  TextStyle get light => defaultTextStyle.copyWith(
      fontWeight: FontWeight.w300,
  );

  TextStyle get regular => defaultTextStyle.copyWith(
      fontWeight: FontWeight.w400,
  );

  TextStyle get medium => defaultTextStyle.copyWith(
      fontWeight: FontWeight.w500,
  );

  TextStyle get semiBold => defaultTextStyle.copyWith(
      fontWeight: FontWeight.w600,
  );

  TextStyle get bold => defaultTextStyle.copyWith(
      fontWeight: FontWeight.w700,
  );

  TextStyle get extraBold => defaultTextStyle.copyWith(
      fontWeight: FontWeight.w800,
  );

  TextStyle get black => defaultTextStyle.copyWith(
      fontWeight: FontWeight.w900,
  );


}
