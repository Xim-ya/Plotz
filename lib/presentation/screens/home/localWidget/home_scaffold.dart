import 'package:uppercut_fantube/utilities/index.dart';

class HomeScaffold extends StatelessWidget {
  const HomeScaffold({
    Key? key,
    required this.animationAppbar,
    required this.scrollController,
    required this.body,
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
  final List<Widget> categoryContentCollectionList;
  final List<Widget> body;
  final ScrollController scrollController;
  final double appBarHeight;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.zero,
      child: Stack(
        children: [
          SingleChildScrollView(
            controller: scrollController,
            child: Stack(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    for (final widget in stackedGradientPosterBg) widget,
                  ],
                ),
                /* 컨텐츠 섹션 */
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: appBarHeight), // 커스텀 앱바와 간격을 맞추기 위한 위젯
                    AppSpace.size72,
                    ...categoryContentCollectionList, // 카테고리 컨텐츠 리스트
                    topBannerSlider, // 상단 대표 컨텐츠 슬라이더
                    ...topTenContentSlider, // Top10 컨텐츠 슬라이더
                    ...body
                  ],
                ),
              ],
            ),
          ),
          ...animationAppbar,
        ],
      ),
    );
  }
}
