import 'package:soon_sak/presentation/common/keep_alive_view.dart';
import 'package:soon_sak/presentation/screens/contentDetail/localWidget/tabView/detail_info_tab_view_scaffold.dart';
import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2022.11.13
 *  컨텐츠 상세 스크린 > 정보 탭뷰 위젯
 * */

class ContentDetailInfoTabView extends BaseView<ContentDetailViewModel> {
  const ContentDetailInfoTabView({Key? key}) : super(key: key);

  @override
  Widget buildView(BuildContext context) {
    return ContentInfoTabViewScaffold(
      creditSection: _buildCreditSection(),
      curatorView: _buildCuratorInfoView(),
      elseInfoView: _buildElseInfoView(),
      contentImgSection: _buildContentImgSection(),
    );
  }

  /// 출연진 정보
  _buildCreditSection() => [
        Obx(
          () => vm.isCreditNotEmpty ?? true
              ? const SectionTitle(title: '출연진', setLeftPadding: true)
              : const SizedBox(),
        ),
        // 출연진 - PageView Slider
        Obx(
          () => CarouselSlider.builder(
            itemCount: vm.contentCreditList.hasData ? vm.sliderCount : 2,
            options: CarouselOptions(
              height: vm.isCreditNotEmpty ?? true ? 224 : 0,
              enableInfiniteScroll: false,
              viewportFraction: 0.93,
            ),
            itemBuilder:
                (BuildContext context, int parentIndex, int pageViewIndex) {
              /// Top Content Section
              return ListView.separated(
                addAutomaticKeepAlives: true,
                separatorBuilder: (__, _) => AppSpace.size16,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: vm.contentCreditList.hasData
                    ? vm.creditLengthOnSlider(parentIndex)!
                    : 3,
                itemBuilder: (context, childIndex) {
                  if (vm.contentCreditList.hasData) {
                    final ContentCreditInfo creditItem = vm.contentCreditList![
                        vm.creditIndex(
                            parentIndex: parentIndex, childIndex: childIndex)];
                    return Row(
                      children: <Widget>[
                        RoundProfileImg(
                          size: 62,
                          imgUrl: creditItem.profilePath?.prefixTmdbImgPath,
                        ),
                        AppSpace.size14,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              creditItem.name,
                              style: AppTextStyle.body1
                                  .copyWith(color: Colors.white),
                            ),
                            Text(creditItem.role, style: AppTextStyle.body1),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return Row(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Shimmer(
                            color: AppColor.mixedWhite,
                            child: Container(
                              height: 62,
                              width: 62,
                              decoration:
                                  const BoxDecoration(shape: BoxShape.circle),
                            ),
                          ),
                        ),
                        AppSpace.size14,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Shimmer(
                              color: AppColor.mixedWhite,
                              child: const SizedBox(
                                width: 56,
                                height: 18,
                              ),
                            ),
                            AppSpace.size8,
                            Shimmer(
                              color: AppColor.mixedWhite,
                              child: Container(
                                height: 18,
                                width: 30,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                },
              );
            },
          ),
        ),
        Obx(() =>
            vm.isCreditNotEmpty ?? true ? AppSpace.size40 : const SizedBox()),
      ];

  /// 큐레이터
  _buildCuratorInfoView() => Padding(
        padding: AppInset.horizontal16,
        child: Row(
          children: <Widget>[
            Obx(
              () => vm.curator != null
                  ? RoundProfileImg(size: 62, imgUrl: vm.curator?.photoUrl)
                  : const SkeletonBox(
                      width: 62,
                      height: 62,
                      borderRadius: 100,
                    ),
            ),
            AppSpace.size10,
            Obx(
              () => vm.curator?.displayName.hasData != null
                  ? Text(
                      vm.curator?.displayName ?? '익명',
                      style: AppTextStyle.headline3,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  : const SkeletonBox(
                      height: 22,
                      width: 50,
                      borderRadius: 4,
                    ),
            ),
          ],
        ),
      );

  // 기타 정보
  _buildElseInfoView() => Obx(
        () => Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 56,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  if (vm.passedArgument.contentType == ContentType.movie)
                    elseInfoItem(title: '방영일', content: vm.releaseDate ?? '-')
                  else
                    elseInfoItem(
                        title: '방영상태', content: vm.contentAirStatus ?? '-'),
                  elseInfoItem(title: '총 좋아요 수', content: vm.likesCount ?? '-'),
                ],
              ),
              Row(
                children: <Widget>[
                  elseInfoItem(
                      title: '총 조회수', content: vm.totalViewCount ?? ''),
                  elseInfoItem(
                      title: '영상 업로드일', content: vm.youtubeUploadDate ?? ''),
                ],
              ),
            ],
          ),
        ),
      );

  // 콘텐츠 이미지
  _buildContentImgSection() => [
        Obx(() => vm.contentImgExist ?? true
            ? const SectionTitle(title: '콘텐츠 이미지', setLeftPadding: true)
            : const SizedBox()),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
          ),
          height: 186,
          child: Obx(
            () => ListView.separated(
              separatorBuilder: (__, _) => AppSpace.size10,
              padding: const EdgeInsets.only(left: 16),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: vm.contentImgList?.length ?? 0,
              itemBuilder: (context, index) {
                final imgItem = vm.contentImgList![index];
                return KeepAliveView(
                  child: CachedNetworkImage(
                    fit: BoxFit.contain,
                    imageUrl: imgItem.prefixTmdbImgPath,
                    height: 100,
                    width: SizeConfig.to.screenWidth - 32,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Shimmer(
                      child: Container(
                        color: AppColor.black,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Center(child: Icon(Icons.error)),
                  ),
                );
              },
            ),
          ),
        )
      ];

  /// 기타정보 > 리스트 아이템
  /// elseInfoItem 2 * 2 형태의 그리드뷰 아이템으로 사용되고 있음
  /// textOverFlow를 구현하기 위해
  /// painter을 이용
  ///
  /// 컨텐츠 텍스트 넓이는  (전체 넓이 / 2) - 32(양 옆 패딩) - 'title'의 텍스트 크기
  /// 로 계산할 수 있음
  Expanded elseInfoItem({required String title, required String content}) {
    TextSpan titleSpan = TextSpan(
      text: title,
      style: AppTextStyle.body2.copyWith(color: Colors.white),
    );
    TextPainter painter = TextPainter(
      text: titleSpan,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );
    painter.layout();
    return Expanded(
      child: Row(
        children: [
          RichText(text: titleSpan),
          SizedBox(
            width: (SizeConfig.to.screenWidth / 2) - 32 - painter.width,
            child: Text(
              ' : $content',
              style: AppTextStyle.body2.copyWith(color: Colors.white),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
