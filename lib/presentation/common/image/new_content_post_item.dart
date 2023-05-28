import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:soon_sak/presentation/common/skeleton_box.dart';
import 'package:soon_sak/utilities/index.dart';

/* Created By Ximya - 2022.05.08
*  새로운 디자인의 포스터 이미지 아이템 위젯
* */

class NewContentPostItem extends StatelessWidget {
  const NewContentPostItem({
    Key? key,
    required this.imgUrl,
    required this.title,
    this.borderRadius = 4,
    this.height = 140,
    this.width = 92,
  }) : super(key: key);

  factory NewContentPostItem.createSkeleton() =>
      const NewContentPostItem(imgUrl: null, title: null);

  final String? imgUrl;
  final String? title;
  final double borderRadius;

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    if (imgUrl.hasData && title.hasData) {
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
          AppSpace.size4,
          Text(
            title ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: PretendardTextStyle.regular(
              height: 14,
              size: 10,
              letterSpacing: -0.2,
            ),
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletonBox(
            borderRadius: borderRadius,
            height: 140,
            width: 92
          ),
          AppSpace.size6,
          const SkeletonBox(
            borderRadius: 4,
            height: 10,
            width: 40,
          )
        ],
      );
    }
  }
}
