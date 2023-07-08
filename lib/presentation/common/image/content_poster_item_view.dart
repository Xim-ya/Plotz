import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/presentation/index.dart';
import 'package:soon_sak/utilities/index.dart';

/* Created By Ximya - 2022.05.08
*  새로운 디자인의 포스터 이미지 아이템 위젯
* */

class ContentPosterItemView extends StatelessWidget {
  const ContentPosterItemView({
    Key? key,
    required this.imgUrl,
    required this.title,
    this.borderRadius = 4,
    this.height = 140,
    this.width = 92,
    this.isSkeleton = false,
  }) : super(key: key);

  factory ContentPosterItemView.createSkeleton() =>
      const ContentPosterItemView(imgUrl: null, title: null, isSkeleton: true,);

  final String? imgUrl;
  final String? title;
  final double borderRadius;
  final double height;
  final double width;
  final bool isSkeleton;

  @override
  Widget build(BuildContext context) {
    if (isSkeleton == false) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: imgUrl!.prefixTmdbImgPath,
              placeholder: (context, url) => const SkeletonBox(),
              errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.error)),
              width: width,
              height: height,
              memCacheHeight: (height * 3).toInt(),
            ),
          ),
          AppSpace.size6,
          SizedBox(
            width: width,
            child: Text(
              title ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: PretendardTextStyle.regular(
                height: 14,
                size: 11,
                letterSpacing: -0.2,
                color: AppColor.gray02,
              ),
            ),
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletonBox(borderRadius: borderRadius, height: 140, width: 92),
          AppSpace.size6,
          const SkeletonBox(
            height: 14,
            width: 40,
          )
        ],
      );
    }
  }
}
