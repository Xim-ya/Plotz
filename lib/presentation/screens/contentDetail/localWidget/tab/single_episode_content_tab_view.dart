import 'package:uppercut_fantube/domain/model/youtube/youtube_content_comment.dart';
import 'package:uppercut_fantube/presentation/common/conditional_rendering_box.dart';
import 'package:uppercut_fantube/utilities/formatter.dart';
import 'package:uppercut_fantube/utilities/index.dart';

/** Created By Ximya - 2022.11.13
 *  '단일 에피소드' 컨텐츠의 경우 에피소드가 존재하는 컨텐츠와 다른 UI가 보여지게 됨.
 *  단일 에피소드 여부에 따라 탭뷰 영역 자체를 다르게 반환.
 * */

class SingleEpisodeContentTabView extends BaseView<ContentDetailViewModel> {
  const SingleEpisodeContentTabView({Key? key}) : super(key: key);

  @override
  Widget buildView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SectionTitle(title: '컨텐츠'),
          // 유튜브 컨텐츠 영상 썸네일
          VideoThumbnailImgWithPlayerBtn(
              onPlayerBtnClicked: () {
                vm.launchYoutubeApp();
              },
              posterImgUrl: vm.contentThumbnailImgUrl ?? ''),
          AppSpace.size4,
          // 좋아요 & 조회수 & 업로드 일자
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Opacity(
                      opacity: 1,
                      child: Icon(
                        Icons.thumb_up,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                    AppSpace.size4,
                    Obx(
                      () => vm.isYoutubeVideoContentInfoLoaded
                          ? Text(
                              Formatter.formatViewAndLikeCount(
                                  vm.youtubeVideoContentInfo?.likeCount),
                              style: AppTextStyle.body3,
                            )
                          : Padding(
                              padding: const EdgeInsets.only(left: 2),
                              child: Shimmer(
                                color: AppColor.lightGrey,
                                child: const SizedBox(
                                  height: 16,
                                  width: 20,
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
                Obx(
                  () => vm.isYoutubeVideoContentInfoLoaded
                      ? Text(
                          '조회수 ${Formatter.formatViewAndLikeCount(
                            vm.youtubeVideoContentInfo?.viewCount,
                            isViewCount: true,
                          )} · ${Formatter.getDateDifferenceFromNow(vm.youtubeVideoContentInfo?.uploadDate)}',
                          style: AppTextStyle.body3,
                        )
                      : Row(
                          children: <Widget>[
                            Shimmer(
                              child: Container(
                                color: AppColor.lightGrey.withOpacity(0.1),
                                height: 16,
                                width: 70,
                              ),
                            ),
                            AppSpace.size6,
                            Shimmer(
                              child: Container(
                                color: AppColor.skeletonGrey,
                                height: 16,
                                width: 36,
                              ),
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ),
          AppSpace.size40,

          const SectionTitle(title: '설명'),
          Obx(
            () => vm.isContentInfoLoaded
                ? Text(
                    vm.contentDescriptionInfo!.overView,
                    style: AppTextStyle.title1
                        .copyWith(fontFamily: 'pretendard_regular'),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (__, _) => Shimmer(
                      child: Container(
                        height: 18,
                      ),
                    ),
                    separatorBuilder: (BuildContext context, int index) =>
                        AppSpace.size4,
                  ),
          ),

          AppSpace.size40,

          // 댓글 - 유튜브 댓글
          const SectionTitle(title: '댓글'),
          Obx(
            () => ListView.separated(
              separatorBuilder: (__, _) => AppSpace.size12,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: vm.commentList?.length ?? 20,
              itemBuilder: (context, index) {
                /// 로딩중일 경우 skeletone 처리
                if (vm.commentList == null) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Shimmer(
                          color: AppColor.lightGrey,
                          child: const SizedBox(
                            height: 38,
                            width: 38,
                          ),
                        ),
                      ),
                      AppSpace.size8,
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Shimmer(
                              color: AppColor.lightGrey,
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                height: 20,
                                width: 60,
                              ),
                            ),
                            AppSpace.size4,
                            Shimmer(
                              color: AppColor.lightGrey,
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                height: 20,
                                width: SizeConfig.to.screenWidth * 0.6,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  final YoutubeContentComment item = vm.commentList![index];
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 38,
                        width: 38,
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              bottom: 0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: SizedBox(
                                  child: SvgPicture.asset(
                                    'assets/icons/${item.profileImgPath}.svg',
                                    height: 33,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                            ),
                            if (item.isHearted)
                              Positioned(
                                top: -2,
                                right: 0,
                                child: SvgPicture.asset(
                                  'assets/icons/heart_ic.svg',
                                  height: 12,
                                ),
                              ),
                          ],
                        ),
                      ),

                      // const RoundProfileImg(
                      //   size: 38,
                      //   imgUrl:
                      //       'https://yt3.ggpht.com/ytc/AMLnZu9mx97jp2uus8qYKYO7gROx18AWIzQprpRdfLIirP19g4qk25l5_ulscs2AWIte2FTnWYE=s48-c-k-c0x00ffffff-no-rj',
                      // ),
                      AppSpace.size8,
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              item.author,
                              style: AppTextStyle.body1
                                  .copyWith(color: Colors.white),
                            ),
                            Text(
                              item.text,
                              style: AppTextStyle.body1
                                  .copyWith(fontFamily: 'pretendard_regular'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
