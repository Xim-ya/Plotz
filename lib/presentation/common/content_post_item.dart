import 'package:uppercut_fantube/utilities/index.dart';

class ContentPostItem extends StatelessWidget {
  const ContentPostItem({Key? key, required this.imgUrl, this.borderRadius = 6}) : super(key: key);

  final String imgUrl;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: AspectRatio(
        aspectRatio: 1280 / 1920,
        child: CachedNetworkImage(
          fit: BoxFit.contain,
          imageUrl:
          imgUrl,
          imageBuilder: (context, imageProvider) =>
              Container(
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
        ),
      ),
    );
  }
}
