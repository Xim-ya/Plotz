import 'package:uppercut_fantube/utilities/index.dart';

class FindContentViewScaffold extends StatelessWidget {
  const FindContentViewScaffold(
      {Key? key,
      required this.header,
      required this.searchBar,
      required this.searchedListView,
      required this.bottomFixedStepBtn})
      : super(key: key);

  final Widget header;
  final Widget searchBar;
  final Widget searchedListView;
  final Widget bottomFixedStepBtn;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Padding(
          padding: AppInset.horizontal16,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverList(
                  delegate: SliverChildListDelegate([
                    header,
                  ]),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: StickyDelegateContainer(
                    minHeight: 56,
                    maxHeight: 1,
                    child: Stack(children: <Widget>[
                      Positioned(
                        top: 0,
                        child: Container(
                          height: 48,
                          width: SizeConfig.to.screenWidth,
                          color: AppColor.black,
                        ),
                      ),
                      searchBar,
                    ]),
                  ),
                )
              ];
            },
            body: // 검색 결과 리스트
                searchedListView,
          ),
        ),
        Positioned(
          bottom: 0,
          child: bottomFixedStepBtn,
        ),
      ],
    );
  }
}
