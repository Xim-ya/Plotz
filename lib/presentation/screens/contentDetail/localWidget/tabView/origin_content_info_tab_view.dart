import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/presentation/index.dart';
import 'package:soon_sak/utilities/index.dart';

class OriginContentInfoTabView extends BaseView<ContentDetailViewModel> {
  const OriginContentInfoTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[
        AppSpace.size40,
        // 별점/평점
        _RateView(),
        AppSpace.size40,

        // 줄거리, 요약
        _SummaryView(),
        AppSpace.size40,

        // 출연진
        _CastView(),
      ],
    );
  }
}

// 출연진
class _CastView extends BaseView<ContentDetailViewModel> {
  const _CastView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<ContentDetailViewModel, List<ContentCreditInfo>?>(
      selector: (context, vm) => vm.contentCreditList,
      builder: (context, creditList, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (creditList?.isNotEmpty ?? true)
              Padding(
                padding: AppInset.left16 + AppInset.bottom12,
                child: Text(
                  '출연진',
                  style: AppTextStyle.title2,
                ),
              )
            else
              const SizedBox.shrink(),

            // 출연진 - PageView Slider
            CarouselSlider.builder(
              itemCount: creditList.hasData ? vm(context).sliderCount : 2,
              options: CarouselOptions(
                height: vm(context).isCreditNotEmpty ?? true ? 220 : 0,
                enableInfiniteScroll: false,
                viewportFraction: 0.93,
              ),
              itemBuilder:
                  (BuildContext context, int parentIndex, int pageViewIndex) {
                /// Top Content Section
                return ListView.separated(
                  separatorBuilder: (__, _) => AppSpace.size16,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: creditList.hasData
                      ? vm(context).creditLengthOnSlider(parentIndex)!
                      : 3,
                  itemBuilder: (context, childIndex) {
                    if (creditList.hasData) {
                      final ContentCreditInfo creditItem =
                          creditList![vm(context).creditIndex(
                        parentIndex: parentIndex,
                        childIndex: childIndex,
                      )];
                      return Row(
                        children: <Widget>[
                          RoundProfileImg(
                            size: 56,
                            imgUrl: creditItem.profilePath?.prefixTmdbImgPath,
                          ),
                          AppSpace.size12,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                creditItem.name,
                                style: AppTextStyle.alert2
                                    .copyWith(color: Colors.white),
                              ),
                              Text(
                                creditItem.role,
                                style: AppTextStyle.alert2.copyWith(
                                  color: AppColor.gray02,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    } else {
                      return Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: const SkeletonBox(
                              borderRadius: 32,
                              height: 56,
                              width: 56,
                            ),
                          ),
                          AppSpace.size14,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              SkeletonBox(
                                width: 56,
                                height: 18,
                              ),
                              AppSpace.size8,
                              SkeletonBox(
                                height: 18,
                                width: 30,
                              )
                            ],
                          ),
                        ],
                      );
                    }
                  },
                );
              },
            ),
            if (creditList?.isNotEmpty ?? true)
              AppSpace.size40
            else
              const SizedBox(),
          ],
        );
      },
    );
  }
}

// 줄거리, 요약
class _SummaryView extends BaseView<ContentDetailViewModel> {
  const _SummaryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppInset.horizontal16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '줄거리',
            style: AppTextStyle.title2,
          ),
          AppSpace.size8,
          Selector<ContentDetailViewModel, String?>(
              selector: (_, vm) => vm.contentOverView,
              builder: (context, overView, _) {
                if (overView.hasData) {
                  if (overView! != '') {
                    return ExpandableTextView(
                      text: overView,
                      maxLines: 3,
                    );
                  } else {
                    return const SizedBox();
                  }
                } else {
                  return ExpandableTextView.createSkeleton();
                }
              })
        ],
      ),
    );
  }
}

// 별점/평점
class _RateView extends BaseView<ContentDetailViewModel> {
  const _RateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<ContentDetailViewModel, double?>(
      selector: (_, vm) => vm.rate,
      builder: (context, rate, _) => Column(
        children: [
          StarRating(rating: rate),
          AppSpace.size7,
          if (rate.hasData)
            Text(
              '${rate!.toStringAsFixed(1)}점',
              style: AppTextStyle.title3,
            )
          else
            const SkeletonBox(
              padding: AppInset.vertical2,
              height: 16,
              width: 32,
            ),
        ],
      ),
    );
  }
}
