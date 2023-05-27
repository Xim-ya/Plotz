import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:soon_sak/app/config/gradient_config.dart';
import 'package:soon_sak/domain/model/content/home/new_content_poster_shell.dart';
import 'package:soon_sak/presentation/base/new_base_view.dart';
import 'package:soon_sak/presentation/common/gridView/paged_grid_list_view.dart';
import 'package:soon_sak/presentation/common/image/circle_img.dart';
import 'package:soon_sak/presentation/common/skeleton_box.dart';
import 'package:soon_sak/presentation/screens/channel/channel_detail_view_model.dart';
import 'package:soon_sak/presentation/screens/channel/localWidget/channel_detail_scaffold.dart';
import 'package:soon_sak/utilities/index.dart';

class ChannelDetailScreen extends NewBaseScreen<ChannelDetailViewModel> {
  const ChannelDetailScreen({Key? key}) : super(key: key);

  @override
  bool get wrapWithSafeArea => false;

  @override
  Widget buildScreen(BuildContext context) {
    return ChannelDetailScaffold(
      appBar: const _AppBar(),
      channelInfoView: const _ChannelInfoView(),
      pagedPosterGridView: const _PagedPosterGridView(),
      scrollController: vm(context).scrollController,
      stackedTopGradientBox: const _StackedTopGradientBox(),
    );
  }

  @override
  ChannelDetailViewModel createViewModel(BuildContext context) =>
      GetIt.I<ChannelDetailViewModel>();
}

/// 페이징이 적용되어 있는 포스터 그리드 뷰
class _PagedPosterGridView extends NewBaseView<ChannelDetailViewModel> {
  const _PagedPosterGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PagedGridListView<NewContentPosterShell>(
      pagingController: vm(context).pagingController,
      itemBuilder:
          (BuildContext context, NewContentPosterShell item, int index) {
        return GestureDetector(
          onTap: () {
            vm(context).routeToContentDetail(item);
          },
          child: Column(
            children: <Widget>[
              KeepAliveView(
                child: Stack(
                  children: [
                    // 이미지
                    AspectRatio(
                      aspectRatio: 109 / 165,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: CachedNetworkImage(
                          memCacheWidth:
                              (SizeConfig.to.screenWidth * (109 / 165)).toInt(),
                          imageUrl: item.posterImgUrl.prefixTmdbImgPath,
                          placeholder: (context, url) => const SkeletonBox(),
                          errorWidget: (_, __, ___) => Container(
                            color: Colors.grey.withOpacity(0.1),
                            child: const Center(
                              child: Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // 콘텐츠 타입 인디케이터
                    Positioned(
                        left: 5,
                        top: 6,
                        child: FittedBox(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                            ),
                            height: 16,
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(15, 15, 15, 0.8),
                                borderRadius: BorderRadius.circular(4)),
                            child: Center(
                              child: Text(
                                item.contentType.name,
                                style: AppTextStyle.nav.copyWith(
                                    color: AppColor.gray02, height: 1.193),
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                item.videoTitle ?? '내용 없음',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.desc.copyWith(color: AppColor.gray02),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// 상댄 채널 뷰
class _ChannelInfoView extends NewBaseView<ChannelDetailViewModel> {
  const _ChannelInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: SizeConfig.to.statusBarHeight + 42,
        ),
        AppSpace.size4,
        RoundProfileImg(size: 90, imgUrl: vm(context).channelInfo.logoImgUrl),
        AppSpace.size8,
        SizedBox(
          width: double.infinity - 32,
          child: Text(
            vm(context).channelInfo.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.headline1,
          ),
        ),
        AppSpace.size4,
        Text(
          '구독자 ${Formatter.formatNumberWithUnit(vm(context).channelInfo.subscribersCount)}명',
          style: AppTextStyle.alert2.copyWith(
            color: AppColor.gray04,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 8),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${vm(context).channelInfo.totalContentCount}개의 콘텐츠',
              style: AppTextStyle.alert2.copyWith(color: AppColor.gray04),
            ),
          ),
        ),
      ],
    );
  }
}

/// 상단 Gradient box
/// state에 따라 Gradient 노출 여부가 결정됨
/// 사실 context를 분리해서 Selecotr를 적용 안해도됨.
class _StackedTopGradientBox extends StatelessWidget {
  const _StackedTopGradientBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<ChannelDetailViewModel, bool>(
      selector: (context, vm) => vm.isScrolledOnPosition,
      builder: (context, value, child) {
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: value ? 1 : 0,
          child: Container(
            height: 172,
            width: SizeConfig.to.screenWidth,
            decoration: const BoxDecoration(
              gradient: AppGradient.topToBottom,
            ),
          ),
        );
      },
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: IconButton(
        onPressed: context.pop,
        icon: SvgPicture.asset(
          'assets/icons/left_arrow.svg',
          height: 24,
          width: 24,
        ),
      ),
    );
  }
}
