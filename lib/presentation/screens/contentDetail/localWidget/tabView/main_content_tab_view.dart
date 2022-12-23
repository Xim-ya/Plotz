import 'package:uppercut_fantube/presentation/common/skeleton_box.dart';
import 'package:uppercut_fantube/utilities/index.dart';

/** Created By Ximya - 2022.11.13
 *  '단일 에피소드' 컨텐츠의 경우 에피소드가 존재하는 컨텐츠와 다른 UI가 보여지게 됨.
 *  단일 에피소드 여부에 따라 탭뷰 영역 자체를 다르게 반환.
 * */

class MainContentTabView extends BaseView<ContentDetailViewModel> {
  const MainContentTabView({Key? key}) : super(key: key);

  @override
  Widget buildView(BuildContext context) =>
      _SingleEpisodeContentTabViewScaffold(
        youtubeContentSection: Obx(() => vm.isSeasonEpisodeContent
            ? buildEpisodeYoutubeContentSection()
            : buildSingleEpisodeYoutubeContentSection()),
        descriptionSection: buildDescriptionSection(),
        commentSection: buildCommentSection(),
      );

  Widget buildEpisodeYoutubeContentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SectionTitle(title: '시즌 에피소드'),
        Obx(
          () => ListView.separated(
            itemCount: vm.contentEpisodeList?.length ?? 2,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              if (vm.contentEpisodeList.hasData) {
                final episodeItem = vm.contentEpisodeList![index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '시즌 ${episodeItem.seasonNumber}',
                      style: AppTextStyle.body1,
                    ),
                    AppSpace.size2,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: vm.seasonEpisodeImgWidth,
                          child: VideoThumbnailImgWithPlayerBtn(
                            aspectRatio: 2 / 3,
                            onPlayerBtnClicked: () {
                              vm.launchYoutubeApp(episodeItem.youtubeVideoId);
                            },
                            posterImgUrl:
                                episodeItem.posterUrl.prefixTmdbImgPath,
                          ),
                        ),
                        AppSpace.size10,
                        Flexible(
                          child: Text(
                            episodeItem.overview,
                            style: AppTextStyle.body3,
                          ),
                        )
                      ],
                    ),
                  ],
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Shimmer(
                      child: const SizedBox(
                        height: 10,
                        width: 56,
                      ),
                    ),
                    AppSpace.size2,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: SizedBox(
                            width: vm.seasonEpisodeImgWidth,
                            child: Shimmer(
                              child: const AspectRatio(aspectRatio: 2 / 3),
                            ),
                          ),
                        ),
                        AppSpace.size10,
                        Column(
                          children: [
                            SkeletonBox(
                              height: 16,
                              width: SizeConfig.to.screenWidth -
                                  vm.seasonEpisodeImgWidth -
                                  42,
                            ),
                            AppSpace.size2,
                            SkeletonBox(
                              height: 16,
                              width: SizeConfig.to.screenWidth -
                                  vm.seasonEpisodeImgWidth -
                                  42,
                            ),
                            AppSpace.size2,
                            SkeletonBox(
                              height: 16,
                              width: SizeConfig.to.screenWidth -
                                  vm.seasonEpisodeImgWidth -
                                  42,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                );
              }
            },
            separatorBuilder: (_, __) => AppSpace.size16,
          ),
        ),
      ],
    );
  }

  // 유튜브 컨텐츠 영상 썸네일
  // 좋아요 & 조회수 & 업로드 일자
  Widget buildSingleEpisodeYoutubeContentSection() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SectionTitle(title: '컨텐츠'),
          Obx(
            () => VideoThumbnailImgWithPlayerBtn(
              onPlayerBtnClicked: () {
                vm.launchYoutubeApp(vm.youtubeContentId);
              },
              posterImgUrl: vm.youtubeImgThumbnailUrl?.value,
            ),
          ),
          AppSpace.size4,
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
                      () => vm.likesCount.hasData
                          ? Text(
                              vm.likesCount!,
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
                  () => vm.viewCount.hasData && vm.youtubeUploadDate.hasData
                      ? Text(
                          '조회수 ${vm.viewCount} · ${vm.youtubeUploadDate}',
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
                                color: AppColor.strongGrey,
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
        ],
      );

  // 컨텐츠 설명(TMDB)
  Widget buildDescriptionSection() => Obx(
        () => vm.contentOverView.hasData
            ? Text(
                vm.contentOverView!,
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
      );

  // 댓글 - 유튜브 댓글
  Widget buildCommentSection() => Obx(
        () => ListView.separated(
          separatorBuilder: (__, _) => AppSpace.size12,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: vm.commentList?.length ?? 10,
          itemBuilder: (context, index) {
            if (vm.commentList.hasData) {
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
                  AppSpace.size8,
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          item.author,
                          style:
                              AppTextStyle.body1.copyWith(color: Colors.white),
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
            } else {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Shimmer(
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
            }
          },
        ),
      );
}

class _SingleEpisodeContentTabViewScaffold extends StatelessWidget {
  const _SingleEpisodeContentTabViewScaffold(
      {Key? key,
      required this.youtubeContentSection,
      required this.descriptionSection,
      required this.commentSection})
      : super(key: key);

  final Widget youtubeContentSection;
  final Widget descriptionSection;
  final Widget commentSection;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          youtubeContentSection,
          AppSpace.size40,
          const SectionTitle(title: '설명'),
          descriptionSection,
          AppSpace.size40,
          const SectionTitle(title: '댓글'),
          commentSection,
        ],
      ),
    );
  }
}
