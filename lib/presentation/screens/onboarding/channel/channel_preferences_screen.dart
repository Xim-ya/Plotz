import 'package:soon_sak/data/api/channel/response/channel_response.dart';
import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/presentation/index.dart';
import 'package:soon_sak/utilities/index.dart';

class ChannelPreferencesScreen extends BaseScreen<ChannelPreferencesViewModel> {
  const ChannelPreferencesScreen({Key? key}) : super(key: key);

  @override
  bool get setBottomSafeArea => false;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size(0, 48),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: context.pop,
              icon: SvgPicture.asset(
                'assets/icons/left_arrow.svg',
                height: 28,
                width: 28,
              ),
            ),
            TextButton(
                onPressed: vm(context).onSkipBtnClicked,
                child: Text(
                  '건너뛰기',
                  style: AppTextStyle.body3.copyWith(color: AppColor.gray01),
                )),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildScreen(BuildContext context) {
    return PreferenceScaffold(
      scrollController: vm(context).scrollController,
      introTextView: const _IntroTextView(),
      pagedGridView: const _ChannelGridView(),
      bottomFixedBtn: const _BottomFixedBtn(),
      topFixedGradientBox: const _GradientBox(),
    );
  }

  @override
  ChannelPreferencesViewModel createViewModel(BuildContext context) =>
      locator<ChannelPreferencesViewModel>();
}

// 상단 고정 Gradient box
class _GradientBox extends StatelessWidget {
  const _GradientBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<ChannelPreferencesViewModel, bool>(
      selector: (_, vm) => vm.hideGradient,
      builder: (_, hideGradient, __) {
        return Positioned(
          top: 0,
          child: IgnorePointer(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: SizeConfig.to.screenWidth,
              height: 88,
              decoration: BoxDecoration(
                gradient: hideGradient ? null : AppGradient.topToBottom,
              ),
            ),
          ),
        );
      },
    );
  }
}

// 하단 고정 버튼
class _BottomFixedBtn extends BaseView<ChannelPreferencesViewModel> {
  const _BottomFixedBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        MaterialButton(
          onPressed: vm(context).onNextBtnTapped,
          color: AppColor.gray06,
          padding: EdgeInsets.only(bottom: SizeConfig.to.bottomInset),
          minWidth: SizeConfig.to.screenWidth,
          height: 48 + SizeConfig.to.bottomInset,
          child: Align(
            alignment: Alignment.topCenter,
            child: Selector<ChannelPreferencesViewModel, bool>(
              selector: (_, vm) => vm.isSufficient,
              builder: (_, isSufficient, __) => Text(
                '다음',
                style: AppTextStyle.headline3.copyWith(
                    color: isSufficient ? AppColor.main : AppColor.gray03),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// 인트로 문구
class _IntroTextView extends StatelessWidget {
  const _IntroTextView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpace.size8,
        Text(
          '마음에 드는 리뷰 유튜버를\n선택해 주세요.',
          style: AppTextStyle.headline1.copyWith(
            color: AppColor.main,
          ),
        ),
        AppSpace.size8,
        Text(
          '다양한 리뷰 콘텐츠 정보를 받아보세요!',
          style: AppTextStyle.body3.copyWith(
            color: AppColor.gray01,
          ),
        ),
        AppSpace.size36,
      ],
    );
  }
}

class _ChannelGridView extends BaseView<ChannelPreferencesViewModel> {
  const _ChannelGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PagedGridListView<ChannelBasicResponse>(
      crossAxisCount: 3,
      mainAxisSpacing: 28,
      crossAxisSpacing: 31,
      childAspectRatio: 96 / 130,
      pagingController: vm(context).pagingController,
      itemBuilder: (_, ChannelBasicResponse item, int index) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            GestureDetector(
              onTap: () {
                vm(context).onChannelItemTapped(item);
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  KeepAliveView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.to.screenWidth * 0.005),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Stack(
                            children: [
                              CachedNetworkImage(
                                memCacheWidth:
                                    (SizeConfig.to.screenWidth * (88 / 137))
                                        .toInt(),
                                imageUrl: item.logoImgUrl,
                                placeholder: (context, url) =>
                                    const SkeletonBox(),
                                errorWidget: (_, __, ___) => Container(
                                  color: Colors.grey.withOpacity(0.1),
                                  child: const Center(
                                    child: Icon(Icons.error),
                                  ),
                                ),
                              ),
                              Positioned(
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 160),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      width: 2,
                                      color: vmW(context)
                                              .selectedChannels
                                              .contains(
                                                item,
                                              )
                                          ? AppColor.main
                                          : Colors.transparent,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    bottom: -42,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          item.name,
                          style: AppTextStyle.alert1,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '구독자 ${Formatter.formatNumberWithUnit(item.subscribersCount)}명',
                          style: AppTextStyle.alert2
                              .copyWith(color: AppColor.gray03),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
