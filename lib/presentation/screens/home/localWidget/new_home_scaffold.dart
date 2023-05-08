import 'package:soon_sak/utilities/index.dart';

/** Edited By Ximya - 2023.03.20
 *  [HomeScreen]에 사용되는 Scaffold Layout 모듈
 *  Paging Layout을 적용하기 위해서 CustomScrollView 기반 'Sliver' 레이아웃으로 구성되어 있음.
 *
 *  홈 스크린 상단에 BackDrop 이미지가 존재하기 때문에
 *  전체 Sliver 레이아웃을 Stack으로 한번 감쌈
 *
 *
 *  NOTE:
 *  [PagingListView.seperated]를 적용하기 위해 Sliver Layout이 적용되어야 함.
 *
 * */

class NewHomeScaffold extends StatelessWidget {
  const NewHomeScaffold({
    Key? key,
    required this.scrollController,
    required this.stackedGradientPosterBg,
    required this.topBannerSlider,
    required this.topTenContentSlider,
    required this.categoryContentCollectionList,
    required this.stackedTopGradient,
    required this.stackedAppBar,
    required this.topPositionedContentSliderList,
  }) : super(key: key);

  final Widget stackedAppBar;
  final List<Widget> stackedGradientPosterBg;
  final Widget topBannerSlider;
  final Widget topTenContentSlider;
  final Widget categoryContentCollectionList;
  final Widget stackedTopGradient;
  final List<Widget> topPositionedContentSliderList;
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
                  // ...stackedGradientPosterBg,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      topBannerSlider,
                      AppSpace.size32,
                      topPositionedContentSliderList[0],
                      topTenContentSlider,
                      topPositionedContentSliderList[1],
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
        stackedTopGradient,
        stackedAppBar,
      ],
    );
  }
}
