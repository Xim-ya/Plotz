import 'package:soon_sak/app/config/gradient_config.dart';
import 'package:soon_sak/utilities/index.dart';

class PreferenceScaffold extends StatelessWidget {
  const PreferenceScaffold({
    Key? key,
    required this.scrollController,
    required this.introTextView,
    required this.pagedGridView,
    required this.bottomFixedBtn,
    required this.topFixedGradientBox,
  }) : super(key: key);

  final ScrollController scrollController;
  final Widget introTextView;
  final Widget pagedGridView;
  final Widget bottomFixedBtn;
  final Widget topFixedGradientBox;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: AppInset.horizontal16,
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: introTextView,
              ),
              pagedGridView,
              const SliverToBoxAdapter(
                child: SizedBox(height: 212),
              ),
            ],
          ),
        ),

        // Graident Box
        topFixedGradientBox,

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
              //하단 버튼
              bottomFixedBtn,

              // 선택된 콘텐츠 개수 표시 Indicator
            ],
          ),
        ),
      ],
    );
  }
}
