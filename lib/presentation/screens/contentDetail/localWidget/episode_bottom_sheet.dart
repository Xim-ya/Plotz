import 'package:soon_sak/domain/model/video/content_video.dart';
import 'package:soon_sak/utilities/index.dart';
/** Created By Ximya - 2022.06.02
 * 커스텀 Bottom Sheet Dialog
 * 에피소드 정보를 선택하는 다이어로그 창을 보여줌
 *
 * */

class EpisodeBottomSheet extends StatelessWidget {
  const EpisodeBottomSheet(
      {Key? key,
      required this.videos,
      required this.onOptionTapped,
      required this.contentType})
      : super(key: key);

  final List<ContentVideo> videos;
  final void Function(int) onOptionTapped;
  final ContentType contentType;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: AppInset.horizontal16 +
            EdgeInsets.only(bottom: SizeConfig.to.bottomInset == 0 ? 12 : 0),
        child: Wrap(
          children: [
            Container(
              height: 48,
              decoration: const BoxDecoration(
                color: AppColor.gray07,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              width: double.infinity,
              child: Center(
                child: Text(
                  '영상 선택',
                  style: AppTextStyle.alert2.copyWith(color: AppColor.gray03),
                ),
              ),
            ),
            Container(
              height: 0.5,
              width: double.infinity,
              color: AppColor.gray06,
            ),
            ListView.separated(
              separatorBuilder: (_, __) => Container(
                height: 0.5,
                width: double.infinity,
                color: AppColor.gray06,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: videos.length,
              itemBuilder: (context, index) {
                final bool isLastItem = videos.length == index + 1;
                return MaterialButton(
                  color: AppColor.gray07,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: isLastItem
                        ? const BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          )
                        : BorderRadius.zero,
                  ),
                  onPressed: () {
                    onOptionTapped(index);
                  },
                  child: SizedBox(
                    height: 56,
                    child: Center(
                      child: Text(
                        contentType.isMovie
                            ? '${index + 1}부'
                            : '시즌 ${index + 1}',
                        style:
                            AppTextStyle.title2.copyWith(color: AppColor.main),
                      ),
                    ),
                  ),
                );
              },
            ),

            AppSpace.size8,
            // 하단 버튼
            MaterialButton(
              color: AppColor.gray07,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onPressed: () {},
              child: const SizedBox(
                height: 56,
                child: Center(
                  child: Text(
                    '닫기',
                    style: TextStyle(
                      color: AppColor.white,
                      fontFamily: 'pretendard_regular',
                      fontSize: 14,
                      letterSpacing: -0.2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

