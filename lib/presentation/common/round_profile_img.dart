import 'package:uppercut_fantube/utilities/index.dart';

class RoundProfileImg extends StatelessWidget {
  const RoundProfileImg({Key? key, required this.size, required this.imgUrl})
      : super(key: key);

  final double size;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: size,
      width: size,
      imageUrl: imgUrl,
      imageBuilder: (context, imageProvider) => Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: imageProvider, fit: BoxFit.contain),
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      placeholder: (context, url) => const SizedBox(),
      // placeholder: (context, url) => ClipRRect(
      //   borderRadius: BorderRadius.circular(100),
      //   child: Shimmer(
      //     child: Container(
      //       color: AppColor.lightGrey,
      //     ),
      //   ),
      // ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
