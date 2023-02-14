import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2022.11.12
 *  Play 아이콘 버튼 & 컨텐츠 썸네일 버튼을 포함하고 있는 UI 모듈
 *  Skeleton 로직도 포함.
 * */

class VideoThumbnailImgWithPlayerBtn extends StatelessWidget {
  const VideoThumbnailImgWithPlayerBtn(
      {Key? key,
      required this.onPlayerBtnClicked,
      required this.posterImgUrl,
      this.checkValidation,
      this.showPlayerBtn = true,
      this.aspectRatio = 16 / 9,
      required})
      : super(key: key);

  final void Function()? checkValidation;
  final VoidCallback onPlayerBtnClicked;
  final String? posterImgUrl;
  final bool showPlayerBtn;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: onPlayerBtnClicked,
          child: AspectRatio(
            aspectRatio: aspectRatio,
            child: posterImgUrl != null
                ? CachedNetworkImage(
                    imageUrl: posterImgUrl!,
                    imageBuilder: (context, imageProvider) => Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    placeholder: (context, url) => Shimmer(
                      child: Container(
                        color: AppColor.black,
                      ),
                    ),
                    errorWidget: (context, url, error) {
                      return const Icon(Icons.error);
                    },
                  )
                : Shimmer(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: AppColor.strongGrey,
                      ),
                    ),
                  ),
          ),
        ),
        if (showPlayerBtn == true)
          Positioned.fill(
            child: Align(
              child: IconInkWellButton(
                iconPath: 'assets/icons/play.svg',
                size: 54,
                onIconTapped: onPlayerBtnClicked,
              ),
            ),
          )
      ],
    );
  }
}
