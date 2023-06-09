import 'package:soon_sak/presentation/common/skeleton_box.dart';
import 'package:soon_sak/utilities/index.dart';

class RoundProfileImg extends StatelessWidget {
  const RoundProfileImg({Key? key, required this.size, required this.imgUrl})
      : super(key: key);

  final double size;
  final String? imgUrl;

  factory RoundProfileImg.createSkeleton({required double size}) =>
      RoundProfileImg(size: size, imgUrl: 'skeleton');

  @override
  Widget build(BuildContext context) {
    if (imgUrl == 'skeleton') {
      return SkeletonBox(
        height: size,
        width: size,
        borderRadius: size / 2,
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: imgUrl.hasData
            ? CachedNetworkImage(
                height: size,
                width: size,
                memCacheHeight: (size * 3).toInt(),
                imageUrl: imgUrl!,
                fit: BoxFit.cover,
                placeholder: (context, url) => const SkeletonBox(),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey.withOpacity(0.1),
                  child: const Center(
                    child: Icon(Icons.error),
                  ),
                ),
              )
            : Container(
                color: Colors.red,
                child: Image.asset(
                  'assets/images/blanck_profile.png',
                  height: size,
                  width: size,
                ),
              ),
      );
    }
  }
}
