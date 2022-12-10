import 'package:uppercut_fantube/utilities/index.dart';

class RoundProfileImg extends StatelessWidget {
  const RoundProfileImg({Key? key, required this.size, required this.imgUrl})
      : super(key: key);

  final double size;
  final String? imgUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: CachedNetworkImage(
        height: size,
        width: size,
        imageUrl: imgUrl!,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            color: Colors.red,
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            // borderRadius: BorderRadius.circular(100),
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
      ),
    );
  }
}
