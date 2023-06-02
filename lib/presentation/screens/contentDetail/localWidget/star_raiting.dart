import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StarRating extends StatelessWidget {
  const StarRating({
    super.key,
    this.rating,
  }); // 별점 아이콘의 색상

  final double? rating; // 평점

  @override
  Widget build(BuildContext context) {
    // 스켈레톤 (로딩처리)
    if (rating == null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
            5, (_) => SvgPicture.asset('assets/icons/star_blank.svg')),
      );
    }

    int numberOfFullStars = rating!.floor(); // 소수점 이하를 버린 정수 부분
    double decimalPart = rating! - numberOfFullStars; // 소수점 이하 부분
    bool hasHalfStar = decimalPart >= 0.5; // 소수점 이하가 0.5 이상인 경우 반채워진 별이 필요
    bool hasEmptyStar =
        decimalPart < 0.5 && decimalPart > 0; // 소수점 이하가 0.5 미만인 경우 빈 별이 필요

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < numberOfFullStars) {
          // 완전 채워진 별 아이콘
          return SvgPicture.asset('assets/icons/star_filled.svg');
        } else if (index == numberOfFullStars && hasHalfStar) {
          // 반채워진 별 아이콘
          return SvgPicture.asset('assets/icons/star_half.svg');
        } else if (index == numberOfFullStars && hasEmptyStar) {
          // 빈 별 아이콘
          return SvgPicture.asset('assets/icons/star_blank.svg');
        } else {
          // 빈 별 아이콘
          return SvgPicture.asset('assets/icons/star_blank.svg');
        }
      }),
    );
  }
}
