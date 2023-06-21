import 'package:provider/provider.dart';
import 'package:soon_sak/app/config/gradient_config.dart';
import 'package:soon_sak/domain/model/content/onboarding/preference_content.dart';
import 'package:soon_sak/presentation/common/gridView/paged_grid_list_view.dart';
import 'package:soon_sak/presentation/screens/onboarding/content/content_preferences_view_model.dart';
import 'package:soon_sak/utilities/index.dart';

class ContentPreferencesScreen extends BaseScreen<ContentPreferenceViewModel> {
  const ContentPreferencesScreen({Key? key}) : super(key: key);

  @override
  bool get setBottomSafeArea => false;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return const PreferredSize(
      preferredSize: Size(0, 48),
      child: SizedBox.expand(),
    );
  }

  @override
  Widget buildScreen(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: AppInset.horizontal16,
          child: CustomScrollView(
            controller: vm(context).scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Column(
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
                    Text(
                      '좋아하는 영화나 드라마 3개를 선택해주세요.',
                      style: AppTextStyle.body3.copyWith(
                        color: AppColor.gray02,
                      ),
                    ),
                    AppSpace.size36,
                  ],
                ),
              ),
              PagedGridListView<PreferenceContent>(
                crossAxisCount: 3,
                mainAxisSpacing: 16,
                crossAxisSpacing: 8,
                childAspectRatio: 109 / 165,
                pagingController: vm(context).pagingController,
                itemBuilder:
                    (BuildContext context, PreferenceContent item, int index) {
                  return GestureDetector(
                    onTap: () {
                      vm(context).onContentTapped(item.contentId);
                    },
                    child: Stack(
                      children: [
                        KeepAliveView(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: CachedNetworkImage(
                              memCacheWidth:
                                  (SizeConfig.to.screenWidth * (109 / 165))
                                      .toInt(),
                              imageUrl: item.posterImgUrl.prefixTmdbImgPath,
                              placeholder: (context, url) =>
                                  const SkeletonBox(),
                              errorWidget: (_, __, ___) => Container(
                                color: Colors.grey.withOpacity(0.1),
                                child: const Center(
                                  child: Icon(Icons.error),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 160),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                width: 2,
                                color: vmW(context)
                                        .selectedContentIds
                                        .contains(item.contentId)
                                    ? AppColor.main
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 212),
              ),
            ],
          ),
        ),


        // Graident Box
        Selector<ContentPreferenceViewModel, bool>(
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

                    gradient:
                        hideGradient ? null : AppGradient.topToBottom,
                  ),
                ),
              ),
            );
          },
        ),
        Positioned(
          bottom: 0,
          child: IgnorePointer(
            child: Container(
              height: SizeConfig.to.screenHeight * 0.37,
              width: SizeConfig.to.screenWidth,
              decoration:
                  const BoxDecoration(gradient: AppGradient.bottomToTop),
            ),
          ),
        ),

        Positioned(
          bottom: 0,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              MaterialButton(
                onPressed: vm(context).onNextBtnTapped,
                color: AppColor.gray07,
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
                          color:
                              isSufficient ? AppColor.main : AppColor.gray04),
                    ),
                  ),
                ),
              ),
              // 선택된 콘텐츠 개수 표시 Indicator
              Positioned(
                top: -28,
                right: 0,
                left: 0,
                child: Align(
                  child: Selector<ContentPreferenceViewModel, int>(
                    selector: (_, vm) => vm.countOfSelectedContent,
                    builder: (_, count, __) => RichText(
                      text: TextSpan(
                        style: AppTextStyle.body2,
                        children: <TextSpan>[
                          TextSpan(
                            text: '$count',
                            style: TextStyle(
                              color:
                                  count > 0 ? AppColor.main : AppColor.gray02,
                            ),
                          ),
                          TextSpan(
                            text: '/3',
                            style: TextStyle(
                              color:
                                  count >= 3 ? AppColor.main : AppColor.gray02,
                            ),
                          )
                        ],
                      ),
                    ),

                    // Text(
                    //   '$count/3',
                    //   style: AppTextStyle.body2.copyWith(
                    //     color: AppColor.main,
                    //   ),
                    // ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  ContentPreferenceViewModel createViewModel(BuildContext context) =>
      locator<ContentPreferenceViewModel>();
}
