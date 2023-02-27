import 'package:soon_sak/utilities/index.dart';

class RoundProfileImg extends StatelessWidget {
  const RoundProfileImg({Key? key, required this.size, required this.imgUrl})
      : super(key: key);

  final double size;
  final String? imgUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: imgUrl.hasData
          ? CachedNetworkImage(
              height: size,
              width: size,
              imageUrl: imgUrl!,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              placeholder: (context, url) => const SizedBox(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            )
          : Image.asset(
              'assets/images/blanck_profile.png',
              height: size,
              width: size,
            ),
    );
  }
}
