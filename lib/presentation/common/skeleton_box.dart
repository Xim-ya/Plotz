import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2023.05.26
 *  로딩 때 처리 보여지는 스켈레톤 박스
 * */

class SkeletonBox extends StatelessWidget {
  const SkeletonBox(
      {Key? key, this.padding, this.borderRadius = 4, this.height, this.width})
      : super(key: key);

  final double? borderRadius;
  final EdgeInsets? padding;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
            color: AppColor.gray07,
            borderRadius: BorderRadius.circular(borderRadius ?? 0)),
        height: height,
        width: width,
      ),
    );
  }
}
