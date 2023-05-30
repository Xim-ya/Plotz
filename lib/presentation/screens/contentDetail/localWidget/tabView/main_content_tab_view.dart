import 'package:provider/provider.dart';
import 'package:soon_sak/presentation/base/base_view.dart';
import 'package:soon_sak/presentation/common/skeleton_box.dart';
import 'package:soon_sak/presentation/screens/contentDetail/localWidget/expandable_text_view.dart';
import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2022.11.13
 *  '단일 에피소드' 컨텐츠의 경우 에피소드가 존재하는 컨텐츠와 다른 UI가 보여지게 됨.
 *  단일 에피소드 여부에 따라 탭뷰 영역 자체를 다르게 반환.
 * */

class MainContentTabView extends BaseView<ContentDetailViewModel> {
  const MainContentTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _MainContentTabViewScaffold(
      youtubeContentSection: vmS<bool>(context, (vm) => vm.isVideoContentLoaded)
          ? const ContentVideoViewsByCase()
          : const _VideCaseSkeletonView(),
      descriptionSection: buildDescriptionSection(context),
      channelSection: buildChannelSection(context),
    );
  }

  /// 컨텐츠 비디오 섹션 Skeleton View
  /// 컨텐츠 타입에 따라 각각 다른 스켈레톤 뷰를 보여줌
  Widget buildContentVideoSectionSkeleton(BuildContext context) {
    if (vm(context).contentType.isMovie ||
        vm(context).contentVideoFormat == ContentVideoFormat.singleTv) {
      return const SingleVideoSkeletonView();
    } else {
      if (vm(context).passedArgument.thumbnailUrl.hasData) {
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
  Widget buildDescriptionSection(BuildContext context) {
    if (vmW(context).contentOverView.hasData) {
      if (vmW(context).contentOverView! != '') {
        return ExpandableTextView(
          text: vmW(context).contentOverView!,
          maxLines: 4,
        );
      } else {
        return const SizedBox();
      }
    } else {
      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: (__, _) => const SkeletonBox(
          height: 18,
        ),


        separatorBuilder: (BuildContext context, int index) => AppSpace.size4,
      );
    }
  }

  // 채널 - 채널정보
  Widget buildChannelSection(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ChannelInfoView(
              nameTextWidth: SizeConfig.to.screenWidth - 104,
              imgSize: 62,
              imgUrl: vmW(context).channelImgUrl,
              name: vmW(context).channelName,
              subscriberCount: vmW(context).subscriberCount,
            ),
            AppSpace.size8,
            // 채널 설명
            if (vmW(context).channelDescription.hasData)
              Text(
                vmW(context).channelDescription!,
                style: AppTextStyle.body2,
              )
            else
              const SkeletonBox(
                width: double.infinity,
                height: 18,
              ),
          ],
        ),
      );
}

class _VideCaseSkeletonView extends BaseView<ContentDetailViewModel> {
  const _VideCaseSkeletonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (vm(context).contentType.isMovie ||
        vm(context).contentVideoFormat == ContentVideoFormat.singleTv) {
      return const SingleVideoSkeletonView();
    } else {
      if (vm(context).passedArgument.thumbnailUrl.hasData) {
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
}

/// 메인 컨텐츠 탭 레이아웃 Scaffold 모듈
/// KeepAlive를 감싸서 불필요한 렌더링을 막음
class _MainContentTabViewScaffold extends StatelessWidget {
  const _MainContentTabViewScaffold({
    Key? key,
    required this.youtubeContentSection,
    required this.descriptionSection,

    required this.channelSection,
  }) : super(key: key);

  final Widget youtubeContentSection;
  final Widget descriptionSection;

  final Widget channelSection;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        youtubeContentSection,
        if (context.select<ContentDetailViewModel, String?>(
              (vm) => vm.contentOverView,
            ) !=
            '')
          Padding(
            padding: AppInset.horizontal16 + AppInset.top40,
            child: const SectionTitle(title: '설명'),
          ),
        Padding(padding: AppInset.horizontal16, child: descriptionSection),
        AppSpace.size40,
        const Padding(
          padding: AppInset.horizontal16,
          child: SectionTitle(title: '채널'),
        ),
        channelSection,
      ],
    );
  }
}

/// 댓글 - 유튜브 댓글
/// 이해할 수 없지만 애플 가이드라인에 위배된다고 함.
/// 일단 삭제
// Widget buildChannelSection() => Obx(
//       () => ListView.separated(
//         separatorBuilder: (__, _) => AppSpace.size12,
//         physics: const NeverScrollableScrollPhysics(),
//         shrinkWrap: true,
//         itemCount: vm.commentList?.length ?? 5,
//         itemBuilder: (context, index) {
//           if (vm.commentList.hasData) {
//             final YoutubeContentComment item = vm.commentList![index];
//             return Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Container(
//                   height: 38,
//                   width: 38,
//                   decoration: const BoxDecoration(
//                     color: Colors.grey,
//                     shape: BoxShape.circle,
//                   ),
//                   child: Stack(
//                     clipBehavior: Clip.none,
//                     alignment: Alignment.center,
//                     children: [
//                       Positioned(
//                         bottom: 0,
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(100),
//                           child: SizedBox(
//                             child: SvgPicture.asset(
//                               'assets/icons/${item.profileImgPath}.svg',
//                               height: 33,
//                               fit: BoxFit.fitWidth,
//                             ),
//                           ),
//                         ),
//                       ),
//                       if (item.isHearted)
//                         Positioned(
//                           top: -2,
//                           right: 0,
//                           child: SvgPicture.asset(
//                             'assets/icons/heart_ic.svg',
//                             height: 12,
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//                 AppSpace.size8,
//                 Flexible(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text(
//                         item.author,
//                         style:
//                             AppTextStyle.body1.copyWith(color: Colors.white),
//                       ),
//                       Text(
//                         item.text,
//                         style: AppTextStyle.body1
//                             .copyWith(fontFamily: 'pretendard_regular'),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           } else {
//             return Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(100),
//                   child: Shimmer(
//                     child: const SizedBox(
//                       height: 38,
//                       width: 38,
//                     ),
//                   ),
//                 ),
//                 AppSpace.size8,
//                 Flexible(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Shimmer(
//                         child: Container(
//                           decoration: const BoxDecoration(
//                             shape: BoxShape.circle,
//                           ),
//                           height: 20,
//                           width: 60,
//                         ),
//                       ),
//                       AppSpace.size4,
//                       Shimmer(
//                         child: Container(
//                           decoration: const BoxDecoration(
//                             shape: BoxShape.circle,
//                           ),
//                           height: 20,
//                           width: SizeConfig.to.screenWidth * 0.6,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           }
//         },
//       ),
//     );
