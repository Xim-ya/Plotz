import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2022.01.24
 *  [PagedListView]의 모듈화한 위젯
 *  [PagedListView]는 delegate 패턴(위임)으로 데이터를 처리하기 때문에
 *  list item을 처리하는 builder부분을 부무 위젯(클래스)이 참조할 수 있도록 함.
 *
 *  ex) final ItemWidgetBuilder<SearchedContent> itemBuilder <-- 매개 변수로 넘김;
 * */

class PagingResultListView extends StatelessWidget {
  const PagingResultListView({
    Key? key,
    required this.focusNode,
    required this.pagingController,
    required this.itemBuilder,
    this.isInitialState,
    required this.firstPageErrorText,
    this.physics,
    this.noItemsFoundText = '검색된 결과가 없습니다',
    this.padding = const EdgeInsets.only(top: 24, bottom: 46),
  }) : super(key: key);

  final FocusNode focusNode;
  final PagingController pagingController;
  final RxBool? isInitialState;
  final ItemWidgetBuilder<SearchedContent> itemBuilder;
  final String firstPageErrorText;
  final String? noItemsFoundText;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (_) {
        focusNode.unfocus();
      },
      child: PagedListView.separated(
        physics: physics,
        padding: padding,
        pagingController: pagingController,
        separatorBuilder: (__, _) => AppSpace.size12,
        builderDelegate: PagedChildBuilderDelegate<SearchedContent>(
          animateTransitions: true,

          /* 다음 페이지 리스트 불러올 때 로딩 Indicator */
          newPageProgressIndicatorBuilder: (context) => const Center(
            child: CircularProgressIndicator(
              strokeWidth: 3.6,
              color: AppColor.darkGrey,
            ),
          ),

          // /* 초기 화면 */
          // firstPageErrorIndicatorBuilder: (context) => term!.isEmpty
          //     ? Center(
          //         child: Text(
          //           firstPageErrorText,
          //           style: AppTextStyle.headline3,
          //         ),
          //       )
          //     : SizedBox(
          //         child: Text(
          //           'aim1',
          //           style: AppTextStyle.headline1,
          //         ),
          //       ),

          /* 검색된 결과가 없을 때 */
          noItemsFoundIndicatorBuilder: (context) => Obx(
            () => isInitialState!.isTrue
                ? Center(
                    child: Text(
                      firstPageErrorText,
                      style: AppTextStyle.headline3,
                    ),
                  )
                : Center(
                  child: SizedBox(
                      child: Text(
                        '검색된 결과가 없습니다',
                        style: AppTextStyle.headline1,
                      ),
                    ),
                ),
          ),
          /* 로딩 인디케이터 */
          firstPageProgressIndicatorBuilder: (context) {
            return const Center(
                child: CircularProgressIndicator(
              color: AppColor.red,
            ));
          },
          /* 검색 결과*/
          itemBuilder: itemBuilder,
        ),
      ),
    );
  }
}
