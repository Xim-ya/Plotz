import 'package:soon_sak/presentation/common/keep_alive_view.dart';
import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2022.11.13
 *  '단일 에피소드' 컨텐츠의 경우 에피소드가 존재하는 컨텐츠와 다른 UI가 보여지게 됨.
 *  단일 에피소드 여부에 따라 탭뷰 영역 자체를 다르게 반환.
 * */

class MainContentTabView extends BaseView<ContentDetailViewModel> {
  const MainContentTabView({Key? key}) : super(key: key);

  @override
  Widget buildView(BuildContext context) {
    return _MainContentTabViewScaffold(
      youtubeContentSection: Obx(
        () => vm.isVideoContentLoaded
            ? const ContentVideoViewsByCase()
            : buildContentVideoSectionSkeleton(),
      ),
      descriptionSection: buildDescriptionSection(),
      commentSection: buildCommentSection(),
    );
  }

  /// 컨텐츠 비디오 섹션 Skeleton View
  /// 컨텐츠 타입에 따라 각각 다른 스켈레톤 뷰를 보여줌
  Widget buildContentVideoSectionSkeleton() {
    if (vm.contentType.isMovie ||
        vm.contentVideoFormat == ContentVideoFormat.singleTv) {
      return const SingleVideoSkeletonView();
    } else {
      if (vm.passedArgument.thumbnailUrl.hasData) {
        return const SingleVideoSkeletonView();
      }
      return const SizedBox(
        height: 200,
        child: Center(
          child: CircularProgressIndicator(
            color: AppColor.darkGrey,
          ),
        ),
      );
    }
  }

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

class _MainContentTabViewScaffold extends StatelessWidget {
  const _MainContentTabViewScaffold(
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        youtubeContentSection,
        AppSpace.size40,
        const Padding(
          padding: AppInset.horizontal16,
          child: SectionTitle(title: '설명'),
        ),
        Padding(padding: AppInset.horizontal16, child: descriptionSection),
        AppSpace.size40,
        const Padding(
          padding: AppInset.horizontal16,
          child: SectionTitle(title: '댓글'),
        ),
        Padding(
          padding: AppInset.horizontal16,
          child: commentSection,
        )
      ],
    );
  }
}
