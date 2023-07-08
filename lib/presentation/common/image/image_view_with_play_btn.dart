import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/utilities/index.dart';
import 'package:soon_sak/presentation/index.dart';

/** Created By Ximya - 2022.11.12
 *  Play 아이콘 버튼 & 컨텐츠 썸네일 버튼을 포함하고 있는 UI 모듈
 *  Skeleton 로직도 포함.
 * */

class ImageViewWithPlayBtn extends StatelessWidget {
  const ImageViewWithPlayBtn({
    Key? key,
    required this.onPlayerBtnClicked,
    required this.posterImgUrl,
    this.showPlayerBtn = true,
    this.aspectRatio = 16 / 9,
    required,
  }) : super(key: key);

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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: AspectRatio(
              aspectRatio: aspectRatio,
              child: posterImgUrl != null
                  ? CachedNetworkImage(
                      memCacheWidth:
                          (SizeConfig.to.screenWidth * aspectRatio).toInt(),
                      imageUrl: posterImgUrl!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const SkeletonBox(),
                      errorWidget: (context, url, error) {
                        return const Icon(Icons.error);
                      },
                    )
                  : const SkeletonBox(),
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
