import 'package:soon_sak/utilities/index.dart';

/** Edited By Ximya - 2023.03.20
 *  [HomeScreen]에 사용되는 Scaffold Layout 모듈
 *  Paging Layout을 적용하기 위해서 CustomScrollView 기반 'Sliver' 레이아웃으로 구성되어 있음.
 *
 *  홈 스크린 상단에 BackDrop 이미지가 존재하기 때문에
 *  전체 Sliver 레이아웃을 Stack으로 한번 감쌈
 *
 * */

class HomeScaffold extends StatelessWidget {
  const HomeScaffold({
    Key? key,
    required this.animationAppbar,
    required this.scrollController,
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
                      SizedBox(height: SizeConfig.to.statusBarHeight + 56),
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