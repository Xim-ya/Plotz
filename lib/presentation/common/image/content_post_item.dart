import 'package:soon_sak/utilities/index.dart';

class ContentPostItem extends StatelessWidget {
  const ContentPostItem(
      {Key? key,
      required this.imgUrl,
      this.borderRadius = 6,
      this.ratio = 1280 / 1920})
      : super(key: key);

  final String? imgUrl;
  final double borderRadius;
  final double? ratio;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: AspectRatio(
        aspectRatio: ratio!,
        child: imgUrl.hasData
            ? CachedNetworkImage(
                fit: BoxFit.contain,
                imageUrl: imgUrl!.prefixTmdbImgPath,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
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
              )
            : const SkeletonBox(),
      ),
    );
  }
}
