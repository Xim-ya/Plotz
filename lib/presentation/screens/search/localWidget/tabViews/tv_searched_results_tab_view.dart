import 'package:uppercut_fantube/utilities/index.dart';

class TvSearchedResultsTabView extends BaseView<SearchViewModel> {
  const TvSearchedResultsTabView({Key? key}) : super(key: key);

  @override
  Widget buildView(BuildContext context) {
    return PagedListView.separated(
      padding: AppInset.top20 + AppInset.bottom46,
      pagingController: vm.pagingController,
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

        /* 초기 화면 */
        firstPageErrorIndicatorBuilder: (context) => Center(
          child: Text(
            '컨텐츠 제목을 입력해주세요',
            style: AppTextStyle.headline3,
          ),
        ),

        /* 검색된 결과가 없을 때 */
        noItemsFoundIndicatorBuilder: (context) => Center(
          child: Text(
            '검색된 결과가 없습니다',
            style: AppTextStyle.title1,
          ),
        ),

        /* 로딩 인디케이터 */
        firstPageProgressIndicatorBuilder: (context) {
          return const Center(
              child: CircularProgressIndicator(
            color: AppColor.darkGrey,
          ));
        },
        /* 검색 결과*/
        itemBuilder: (context, item, index) {
          // 컨텐츠 등록 여부에 따른 인디케이터 case별 위젯 (이미지 overlay)
          Widget caseOverlayIndicatorOnImg() {
            switch (item.isRegisteredContent.value) {
              case ContentRegisteredValue.isLoading:
                return const SizedBox();
              case ContentRegisteredValue.registered:
                return Positioned.fill(
                  child: Align(
                    child: IconInkWellButton(
                      iconPath: 'assets/icons/play.svg',
                      iconSize: 40,
                      onIconTapped: () {},
                    ),
                  ),
                );
              case ContentRegisteredValue.unRegistered:
                return Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.black.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
            }
          }

          // 컨텐츠 등록 여부 인디케이터 case별 위젯
          Widget caseIndicatorOnTrailing() {
            switch (item.isRegisteredContent.value) {
              case ContentRegisteredValue.isLoading:
                return const SizedBox(
                  height: 12,
                  width: 12,
                  child: CircularProgressIndicator(
                    color: AppColor.darkGrey,
                    strokeWidth: 2,
                  ),
                );
              case ContentRegisteredValue.registered:
                return const SizedBox();
              case ContentRegisteredValue.unRegistered:
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset('assets/icons/round_exclamation.svg'),
                    AppSpace.size2,
                    Text(
                      '등록되지 않은 컨텐츠 입니다',
                      style: AppTextStyle.alert2
                          .copyWith(color: const Color(0xFF303030)),
                    ),
                  ],
                );
            }
          }

          return GestureDetector(
            onTap: () {},
            child: Row(
              children: <Widget>[
                // 컨텐츠 포스터 이미지
                Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: CachedNetworkImage(
                          imageUrl: item.posterImgUrl?.prefixTmdbImgPath ?? '',
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          placeholder: (context, url) => Shimmer(
                            child: Container(
                              color: AppColor.black,
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: AppColor.darkGrey,
                            child: const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                    Obx(caseOverlayIndicatorOnImg)
                  ],
                ),
                AppSpace.size8,
                SizedBox(
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AppSpace.size2,
                      // 제목
                      SizedBox(
                        width: SizeConfig.to.screenWidth - 140,
                        child: Text(
                          item.title ?? '제목 없음',
                          style: AppTextStyle.title1,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      AppSpace.size2,
                      // 개봉 & 첫 방영일

                      if (item.releaseDate != null || item.releaseDate != '')
                        Text(
                          item.releaseDate != null
                              ? Formatter.dateToyyMMdd(item.releaseDate!)
                              : '방영일 확인 불가',
                          style: AppTextStyle.body2
                              .copyWith(color: AppColor.lightGrey),
                        ),
                      AppSpace.size2,
                      // 등록 여부 Indicator
                      Obx(
                        caseIndicatorOnTrailing,
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
