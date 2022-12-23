import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:uppercut_fantube/domain/model/content/searched_content.dart';
import 'package:uppercut_fantube/presentation/common/skeleton_box.dart';
import 'package:uppercut_fantube/presentation/screens/search/search_view_model.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class DramaSearchedResultsTabView extends BaseView<SearchViewModel> {
  const DramaSearchedResultsTabView({Key? key}) : super(key: key);

  @override
  Widget buildView(BuildContext context) {
    return PagedListView.separated(
      padding: AppInset.top20 + AppInset.bottom46,
      pagingController: vm.pagingController,
      separatorBuilder: (__, _) => AppSpace.size12,
      builderDelegate: PagedChildBuilderDelegate<SearchedContent>(

          /* 검색된 결과가 없을 때 */
          noItemsFoundIndicatorBuilder: (context) => Center(
                child: Text(
                  '검색된 결과가 없습니다',
                  style: AppTextStyle.title1,
                ),
              ),
          /* 초기 화면 */
          firstPageProgressIndicatorBuilder: (context) {
            return Center(
              child: Text(
                '컨텐츠 제목을 입력해주세요',
                style: AppTextStyle.title1,
              ),
            );
          },
          itemBuilder: (context, item, index) {
            if (item.hasData) {
              return Row(
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
                            imageUrl:
                                item.posterImgUrl?.prefixTmdbImgPath ?? '',
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
                      if (true)
                        Positioned.fill(
                          child: Align(
                            child: IconInkWellButton(
                              iconPath: 'assets/icons/play.svg',
                              iconSize: 40,
                              onIconTapped: () {},
                            ),
                          ),
                        ),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SvgPicture.asset(
                                'assets/icons/round_exclamation.svg'),
                            AppSpace.size2,
                            Text(
                              '등록되지 않은 컨텐츠 입니다',
                              style: AppTextStyle.alert2
                                  .copyWith(color: const Color(0xFF303030)),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Row(
                children: <Widget>[
                  // 컨텐츠 포스터 이미지
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: const SkeletonBox(
                      height: 100,
                      width: 100,
                    ),
                  ),
                  AppSpace.size8,
                  SizedBox(
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AppSpace.size2,
                        // 제목
                        Row(
                          children: [
                            Text(
                              '왕좌의 게임',
                              style: AppTextStyle.title1,
                            ),
                            AppSpace.size2,
                            // 컨텐츠 등록 여부
                            SvgPicture.asset('assets/icons/check_box.svg'),
                          ],
                        ),
                        // 개봉 & 첫 방영일
                        Text(
                          Formatter.dateToyyMMdd('2022-11-12'),
                          style: AppTextStyle.body2
                              .copyWith(color: AppColor.lightGrey),
                        ),
                        AppSpace.size2,
                        // 등록 여부 Indicator
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SvgPicture.asset(
                                'assets/icons/round_exclamation.svg'),
                            AppSpace.size2,
                            Text(
                              '등록되지 않은 컨텐츠 입니다',
                              style: AppTextStyle.alert2
                                  .copyWith(color: const Color(0xFF303030)),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }
}
