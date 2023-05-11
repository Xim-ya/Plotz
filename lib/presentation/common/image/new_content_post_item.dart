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
      return SizedBox(
            width: 92,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CachedNetworkImage(
                  height: 140,
                  fit: BoxFit.cover,
                  imageUrl: imgUrl!.prefixTmdbImgPath,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(borderRadius),
                      border: Border.all(width: 0.75, color: AppColor.gray06),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Shimmer(
                    child: Container(
                      color: AppColor.black,
                    ),
                  ),
                  errorWidget: (context, url, error) =>
                      const Center(child: Icon(Icons.error)),
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
            ),
          );
    } else {
      return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SkeletonBox(
                height: 140,
                width: 92,
              ),
              AppSpace.size6,
              SizedBox(
                height: 10,
                width: 40,
                child: SkeletonBox(),
              )
            ],
          );
    }
  }
}
