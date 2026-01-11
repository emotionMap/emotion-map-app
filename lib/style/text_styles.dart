part of 'index.dart';

class NotoSansKR {
  NotoSansKR._();

  static const thin = TextStyle(
    fontFamily: "NotoSansKR",
    fontWeight: FontWeight.w100,
  );

  static const extraLight = TextStyle(
    fontFamily: "NotoSansKR",
    fontWeight: FontWeight.w200,
  );

  static const light = TextStyle(
    fontFamily: "NotoSansKR",
    fontWeight: FontWeight.w300,
  );

  static const regular = TextStyle(
    fontFamily: "NotoSansKR",
    fontWeight: FontWeight.w400,
  );

  static const medium = TextStyle(
    fontFamily: "NotoSansKR",
    fontWeight: FontWeight.w500,
  );

  static const semiBold = TextStyle(
    fontFamily: "NotoSansKR",
    fontWeight: FontWeight.w600,
  );

  static const bold = TextStyle(
    fontFamily: "NotoSansKR",
    fontWeight: FontWeight.w700,
  );

  static const extraBold = TextStyle(
    fontFamily: "NotoSansKR",
    fontWeight: FontWeight.w800,
  );

  static const black = TextStyle(
    fontFamily: "NotoSansKR",
    fontWeight: FontWeight.w900,
  );
}

extension DoubleExtension on double {
  double toFigmaLineHeight(double fontSize) => this / fontSize;
}

extension IntExtension on int {
  double toFigmaLineHeight(int fontSize) => this / fontSize;
}

extension TextStyleExtension on TextStyle {
  TextStyle set({
    required double size,
    double? height,
    double? fixedHeight,
    Color? color,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
    Paint? foreground,
  }) => copyWith(
    fontSize: size,
    height: height ?? fixedHeight?.toFigmaLineHeight(size) ?? 1,
    leadingDistribution: TextLeadingDistribution.even,
    color: color,
    letterSpacing: letterSpacing,
    decoration: decoration,
    decorationColor: decorationColor ?? color,
    foreground: foreground,
  );
}
