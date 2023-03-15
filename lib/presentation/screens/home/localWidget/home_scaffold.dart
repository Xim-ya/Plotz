import 'package:soon_sak/utilities/index.dart';

class HomeScaffold extends StatelessWidget {
  const HomeScaffold({
    Key? key,
    required this.animationAppbar,
    required this.scrollController,
    required this.appBarHeight,
    required this.stackedGradientPosterBg,
    required this.topBannerSlider,
    required this.topTenContentSlider,
    required this.categoryContentCollectionList,
  }) : super(key: key);

  final List<Widget> animationAppbar;
  final List<Widget> stackedGradientPosterBg;
  final Widget topBannerSlider;
  final List<Widget> topTenContentSlider;
  final Widget categoryContentCollectionList;
  final ScrollController scrollController;
  final double appBarHeight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(
          shrinkWrap: true,
          controller: scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Stack(
                children: [
                  ...stackedGradientPosterBg,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: appBarHeight),
                      // 커스텀 앱바와 간격을 맞추기 위한 위젯
                      topBannerSlider,
                      ...topTenContentSlider,
                      AppSpace.size32,
                    ],
                  ),
                ],
              ),
            ),
            categoryContentCollectionList,
            const SliverToBoxAdapter(
              child: AppSpace.size72,
            ),
          ],
        ),
        ...animationAppbar,
      ],
    );
  }
}