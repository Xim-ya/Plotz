import 'dart:io';
import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/presentation/index.dart';
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

class HomeScaffold extends StatelessWidget {
  const HomeScaffold({
    Key? key,
    required this.scrollController,
    required this.topBannerSlider,
    required this.topTenSlider,
    required this.newlyAddedContentSlider,
    required this.categoryContentCollectionList,
    required this.channelSlider,
    required this.stackedTopGradient,
    required this.stackedAppBar,
    required this.topPositionedContentSliderList,
  }) : super(key: key);

  final Widget stackedAppBar;
  final Widget topBannerSlider;
  final Widget newlyAddedContentSlider;
  final Widget topTenSlider;
  final Widget categoryContentCollectionList;
  final Widget stackedTopGradient;
  final Widget channelSlider;
  final List<Widget> topPositionedContentSliderList;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return ConditionalWillPopScope(
      shouldAddCallback: Platform.isIOS ? false : true,
      onWillPop: () async {
        await showDialog(
          context: context,
          builder: (_) => AppDialog.dividedBtn(
            title: '알림',
            description: 'Plotz를 종료하시겠습니까?',
            leftBtnContent: '확인',
            rightBtnContent: '취소',
            onRightBtnClicked: () {
              context.pop();
            },
            onLeftBtnClicked: () {
              context.pop();
              exit(0);
            },
          ),
        );
        return false;
      },
      child: Stack(
        children: [
          CustomScrollView(
            shrinkWrap: true,
            controller: scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        topBannerSlider,
                        AppSpace.size32,
                        newlyAddedContentSlider,
                        topTenSlider,
                        AppSpace.size14,
                        topPositionedContentSliderList[0],
                        AppSpace.size32,
                        channelSlider,
                        AppSpace.size32,
                      ],
                    ),
                  ],
                ),
              ),
              categoryContentCollectionList,
              const SliverToBoxAdapter(
                child: AppSpace.size52,
              ),
            ],
          ),
          stackedTopGradient,
          stackedAppBar,
        ],
      ),
    );
  }
}
