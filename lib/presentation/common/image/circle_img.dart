import 'package:soon_sak/presentation/common/skeleton_box.dart';
import 'package:soon_sak/presentation/index.dart';
import 'package:soon_sak/utilities/index.dart';

class CircleImg extends StatelessWidget {
  const CircleImg({Key? key, required this.size, required this.imgUrl})
      : super(key: key);

  final double size;
  final String? imgUrl;

  factory CircleImg.skeleton({required double size}) =>
      CircleImg(size: size, imgUrl: null);

  @override
  Widget build(BuildContext context) => imgUrl.hasData
      ? ClipRRect(
          borderRadius: BorderRadius.circular(size / 2),
          child: CachedNetworkImage(
            height: size,
            width: size,
            memCacheWidth: size.cacheSize(context),
            imageUrl: imgUrl!,
            errorWidget: (context, url, error) => Container(
              color: Colors.grey.withOpacity(0.1),
              child: const Center(
                child: Icon(Icons.error),
              ),
            ),
          ),
        )
      : SizedBox(
          height: size,
          width: size,
          child: SkeletonBox(
            borderRadius: size / 2,
          ),
        );
}
