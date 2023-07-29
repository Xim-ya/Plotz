import 'package:soon_sak/domain/model/content/onboarding/preference_content.dart';
import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/presentation/index.dart';
import 'package:soon_sak/utilities/index.dart';

class ContentPreferencesScreen extends BaseScreen<ContentPreferenceViewModel> {
  const ContentPreferencesScreen({Key? key}) : super(key: key);

  @override
  Widget buildScreen(BuildContext context) {
    return PreferenceScaffold(
      scrollController: vm(context).scrollController,
      introTextView: const _IntroTextView(),
      pagedGridView: const _PosterGridView(),
      bottomFixedBtn: const _BottomFixedBtn(),
      topFixedGradientBox: const _GradientBox(),
    );
  }

  @override
  ContentPreferenceViewModel createViewModel(BuildContext context) =>
      locator<ContentPreferenceViewModel>();

  @override
  bool get setBottomSafeArea => false;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return const PreferredSize(
      preferredSize: Size(0, 48),
      child: SizedBox.expand(),
    );
  }
}

// 상단 고정 gradient box
class _GradientBox extends BaseView<ContentPreferenceViewModel> {
  const _GradientBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<ContentPreferenceViewModel, bool>(
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
class _BottomFixedBtn extends BaseView<ContentPreferenceViewModel> {
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
            child: Selector<ContentPreferenceViewModel, bool>(
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

// 콘텐츠 포스터 그리드 뷰 (페이징)
class _PosterGridView extends BaseView<ContentPreferenceViewModel> {
  const _PosterGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PagedGridListView<PreferredContent>(
      crossAxisCount: 3,
      mainAxisSpacing: 16,
      crossAxisSpacing: 8,
      childAspectRatio: 109 / 165,
      pagingController: vm(context).pagingController,
      itemBuilder: (BuildContext context, PreferredContent item, int index) {
        return GestureDetector(
          onTap: () {
            vm(context).onContentTapped(item);
          },
          child: KeepAliveView(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 140),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.2),
                border: Border.all(
                  width: 2,
                  color: vmW(context).selectedContent.contains(item)
                      ? AppColor.main
                      : Colors.transparent,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  vmW(context).selectedContent.contains(item) ? 0 : 4,
                ),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  memCacheWidth:
                  (SizeConfig.to.screenWidth.cacheSize(context) * 0.21).toInt(),
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
          ),
        );
      },
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
          '당신의 취향을\n알려주세요.',
          style: AppTextStyle.headline1.copyWith(
            color: AppColor.main,
          ),
        ),
        AppSpace.size8,
        Text.rich(
          style: AppTextStyle.body3.copyWith(
            color: AppColor.gray01,
          ),
          TextSpan(
            children: <TextSpan>[
              const TextSpan(
                text: '좋아하는 영화나 드라마 ',
              ),  
              TextSpan(
                text: '3개 이상',
                style: AppTextStyle.body3.copyWith(
                  color: AppColor.main,
                ),
              ),
              const TextSpan(
                text: ' 선택해주세요',
              )
            ],
          ),
        ),
        AppSpace.size36,
      ],
    );
  }
}
