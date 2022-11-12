import 'package:uppercut_fantube/utilities/index.dart';

class VideoThumbnailImgWithPlayerBtn extends StatelessWidget {
  const VideoThumbnailImgWithPlayerBtn(
      {Key? key,
      required this.onPlayerBtnClicked,
      required this.posterImgUrl,
      })
      : super(key: key);

  final VoidCallback onPlayerBtnClicked;
  final String posterImgUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 16/9,
          child: CachedNetworkImage(
            imageUrl: posterImgUrl,
            imageBuilder: (context, imageProvider) => Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(image: imageProvider, fit: BoxFit.fitWidth),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            placeholder: (context, url) => Shimmer(
              child: Container(
                color: AppColor.black,
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        Positioned.fill(
          child: Align(
            child: IconInkWellButton(
              iconPath: 'assets/icons/play.svg',
              iconSize: 54,
              onIconTapped: onPlayerBtnClicked,
            ),
          ),
        ),
      ],
    );
  }
}
