import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/presentation/index.dart';
import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2023.03.15
 *  [PagedListView]의 모듈화한 위젯
 *  list item을 처리하는 builder부분을 부무 위젯(클래스)이 참조할 수 있도록 함.
 * */

class PagedCategoryListView extends StatelessWidget {
  const PagedCategoryListView({
    Key? key,
    required this.pagingController,
    required this.itemBuilder,
  }) : super(key: key);

  final PagingController pagingController;
  final ItemWidgetBuilder<CategoryContentSection> itemBuilder;

  @override
  Widget build(BuildContext context) {
    return PagedSliverList.separated(
      pagingController: pagingController,
      separatorBuilder: (__, _) => AppSpace.size32,
      builderDelegate: PagedChildBuilderDelegate<CategoryContentSection>(
        // animateTransitions: true,

        /* 다음 페이지 리스트 불러올 때 로딩 Indicator */
        newPageProgressIndicatorBuilder: (context) => const Center(
          child: CircularProgressIndicator(
            strokeWidth: 3.6,
            color: AppColor.darkGrey,
          ),
        ),

        /* 에러 문구 */
        firstPageErrorIndicatorBuilder: (context) {
          return Expanded(
            child: Center(
              child: Text(
                '카테고리 정보를 불러오는데 실패했어요',
                style: AppTextStyle.headline3,
                textAlign: TextAlign.center,
              ),
            ),
          );
        },

        /* 로딩 인디케이터 */
        firstPageProgressIndicatorBuilder: (context) {
          return Column(
            children: List.generate(
              4,
              (index) => const Column(
                children: [
                  CategoryContentSectionSkeletonView(),
                  AppSpace.size32,
                ],
              ),
            ),
          );
        },
        /* 검색 결과*/
        itemBuilder: itemBuilder,
      ),
    );
  }
}
