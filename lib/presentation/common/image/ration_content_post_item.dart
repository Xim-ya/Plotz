import 'package:soon_sak/presentation/common/skeleton_box.dart';
import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/presentation/index.dart';
import 'package:soon_sak/utilities/index.dart';

class RatioContentPostItem extends StatelessWidget {
  const RatioContentPostItem({
    Key? key,
    required this.imgUrl,
    this.borderRadius = 6,
    this.ratio = 1280 / 1920,
  }) : super(key: key);

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
                memCacheWidth:
                    ((SizeConfig.to.screenWidth * ratio!) * 1.4).toInt(),
                fit: BoxFit.contain,
                imageUrl: imgUrl!.prefixTmdbImgPath,
                placeholder: (context, url) => const SkeletonBox(),
                errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.error)),
              )
            : const SkeletonBox(),
      ),
    );
  }
}
