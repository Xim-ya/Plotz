import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2022.12.26
 *  로딩 때 처리 보여지는 스켈레톤 박스
 * */

class SkeletonBox extends StatelessWidget {
  const SkeletonBox(
      {Key? key, this.padding, this.borderRadius, this.height, this.width, this.color})
      : super(key: key);

  final double? borderRadius;
  final EdgeInsets? padding;
  final double? height;
  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
        child: Shimmer(
          child: Container(
            height: height,
            width: width,
            color: color,
          ),
        ),
      ),
    );
  }
}
