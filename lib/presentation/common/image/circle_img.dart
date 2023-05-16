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
      ? CachedNetworkImage(
          height: size,
          width: size,
          imageUrl: imgUrl!,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            color: Colors.grey.withOpacity(0.1),
            child: const Center(
              child: Icon(Icons.error),
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
