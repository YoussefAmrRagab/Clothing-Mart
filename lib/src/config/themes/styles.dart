import 'package:flutter/material.dart';
import '../../config/themes/colors.dart';
import 'dimens.dart';

class TextStyles {
  static TextStyle encodeSansW800S22 = const TextStyle(
    fontFamily: 'EncodeSans',
    fontWeight: FontWeight.w800,
    fontSize: Dimensions.s22,
  );
  static TextStyle encodeSansW800S24 = const TextStyle(
    fontFamily: 'EncodeSans',
    fontWeight: FontWeight.w800,
    fontSize: Dimensions.s24,
  );
  static TextStyle whiteEncodeSansW800S18 = const TextStyle(
    fontFamily: 'EncodeSans',
    fontWeight: FontWeight.w800,
    fontSize: Dimensions.s18,
    color: Colors.white,
  );
  static TextStyle encodeSansW800S18 = const TextStyle(
    fontFamily: 'EncodeSans',
    fontWeight: FontWeight.w800,
    fontSize: Dimensions.s18,
  );
  static TextStyle encodeSansW600S16 = const TextStyle(
    fontFamily: 'EncodeSans',
    fontWeight: FontWeight.w600,
    fontSize: Dimensions.s16,
  );
  static TextStyle encodeSansW800S12 = const TextStyle(
    fontFamily: 'EncodeSans',
    fontWeight: FontWeight.w800,
    fontSize: Dimensions.s12,
  );
  static TextStyle encodeSansW200S14 = const TextStyle(
    fontFamily: 'EncodeSans',
    fontWeight: FontWeight.w200,
    fontSize: Dimensions.s14,
  );
  static TextStyle greyEncodeSansW100S12 = TextStyle(
    fontFamily: 'EncodeSans',
    fontWeight: FontWeight.w100,
    fontSize: Dimensions.s12,
    color: ColorManager.lightGrayColor,
  );
}
