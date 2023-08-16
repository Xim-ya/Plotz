import 'package:soon_sak/utilities/index.dart';
import 'package:soon_sak/app/index.dart';

/** Created By Ximya - 2022.11.04
 * TextStyle을 상속 받는 [PretendardTextStyle] 모듈을 기반으로 함.
 * factory Pattern으로 폰트 굵기에 따라 [TextStyle] 인스턴스를 생성
 * [TextLeadingDistribution.even]속성은 폰트 기본 높이보다 크기가 높게 설정되어 있을 때 Vertical center 정렬이 가능하게 함.
 * */

abstract class AppTextStyle {
  static TextStyle extraFont = const TextStyle(
    fontFamily: 'staatliches_regular',
    fontSize: 24,
  );

  static TextStyle web1 = PretendardTextStyle.bold(
    size: 40,
    height: 52,
    letterSpacing: -0.2,
  );

  static TextStyle web2 = PretendardTextStyle.bold(
    size: 36,
    height: 46,
    letterSpacing: -0.2,
  );

  static TextStyle web3 = PretendardTextStyle.bold(
    size: 32,
    height: 48,
    letterSpacing: -0.2,
  );

  static TextStyle headline3 = PretendardTextStyle.semiBold(
    size: 18,
    height: 22,
    letterSpacing: -0.2,
  );

  static TextStyle headline2 = PretendardTextStyle.bold(
    size: 20,
    height: 30,
    letterSpacing: -0.2,
  );

  static TextStyle headline1 = PretendardTextStyle.bold(
    size: 24,
    height: 37,
    letterSpacing: -0.2,
  );

  static TextStyle title3 = PretendardTextStyle.bold(
    size: 15,
    height: 22,
    letterSpacing: -0.2,
  );
  static TextStyle title3Bold = PretendardTextStyle.bold(
    size: 14,
    height: 20,
  );

  static TextStyle title2 = PretendardTextStyle.semiBold(
    size: 16,
    height: 22,
    letterSpacing: -0.2,
  );

  static TextStyle title1 = PretendardTextStyle.bold(
    size: 16,
    height: 22,
    letterSpacing: -0.2,
  );

  static TextStyle body3 = PretendardTextStyle.medium(
    size: 14,
    height: 20,
    letterSpacing: -0.2,
  );

  static TextStyle body2 = PretendardTextStyle.medium(
    size: 15,
    height: 22,
    letterSpacing: -0.2,
  );

  static TextStyle body1 = PretendardTextStyle.semiBold(
    size: 15,
    height: 22,
    letterSpacing: -0.2,
  );

  static TextStyle alert1 = PretendardTextStyle.semiBold(
    size: 13,
    height: 18,
    letterSpacing: -0.2,
  );

  static TextStyle alert2 = PretendardTextStyle.regular(
    size: 13,
    height: 18,
    letterSpacing: -0.2,
  );

  static TextStyle desc = PretendardTextStyle.regular(
    size: 12,
    height: 14,
    letterSpacing: -0.2,
  );

  static TextStyle nav = PretendardTextStyle.medium(
    size: 12,
    letterSpacing: -0.2,
  );
}

class PretendardTextStyle extends TextStyle {
  static const pretendardBold = 'pretendard_bold';
  static const pretendardRegular = 'pretendard_regular';
  static const pretendardSemiBold = 'pretendard_semiBold';
  static const pretendardMedium = 'pretendard_medium';

  const PretendardTextStyle(
    String fontFamily,
    Color color,
    double size,
    FontWeight fontWeight,
    double height,
    double? letterSpacing,
  ) : super(
            fontFamily: fontFamily,
            color: color,
            fontSize: size,
            fontWeight: fontWeight,
            height: height / size,
            letterSpacing: letterSpacing,
            leadingDistribution: TextLeadingDistribution.even);

  factory PretendardTextStyle.regular({
    required double size,
    Color color = AppColor.white,
    FontWeight fontWeight = FontWeight.normal,
    double height = 1.0,
    double? letterSpacing,
  }) =>
      PretendardTextStyle(
          pretendardRegular, color, size, fontWeight, height, letterSpacing);

  factory PretendardTextStyle.semiBold({
    required double size,
    Color color = AppColor.white,
    FontWeight fontWeight = FontWeight.normal,
    double height = 1.0,
    double? letterSpacing,
  }) =>
      PretendardTextStyle(
          pretendardSemiBold, color, size, fontWeight, height, letterSpacing);

  factory PretendardTextStyle.medium({
    required double size,
    Color color = AppColor.white,
    FontWeight fontWeight = FontWeight.normal,
    double height = 1.0,
    double? letterSpacing,
  }) =>
      PretendardTextStyle(
          pretendardMedium, color, size, fontWeight, height, letterSpacing);

  factory PretendardTextStyle.bold({
    required double size,
    Color color = AppColor.white,
    FontWeight fontWeight = FontWeight.normal,
    double height = 1.0,
    double? letterSpacing,
  }) =>
      PretendardTextStyle(
          pretendardBold, color, size, fontWeight, height, letterSpacing);
}
