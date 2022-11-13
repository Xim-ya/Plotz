import 'package:uppercut_fantube/utilities/index.dart';

/** Created By Ximya - 2022.11.12
 *  Play 아이콘 버튼 & 컨텐츠 썸네일 버튼을 포함하고 있는 UI 모듈
 *  Skeleton 로직도 포함.
 * */

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
