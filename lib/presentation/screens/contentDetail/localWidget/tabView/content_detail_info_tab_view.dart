import 'package:provider/provider.dart';
import 'package:soon_sak/presentation/base/new_base_view.dart';
import 'package:soon_sak/presentation/common/skeleton_box.dart';
import 'package:soon_sak/presentation/screens/contentDetail/localWidget/tabView/detail_info_tab_view_scaffold.dart';
import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2022.11.13
 *  컨텐츠 상세 스크린 > 정보 탭뷰 위젯
 * */

class ContentDetailInfoTabView extends NewBaseView<ContentDetailViewModel> {
  const ContentDetailInfoTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ContentInfoTabViewScaffold(
      creditSection: _CreditSectionView(),
      curatorView: _CurationSectionView(),
      elseInfoView: _ElseInfoSectionView(),
      contentImgSection: _ContentImageSectionView(),
    );
  }
}

// 콘텐츠 이미지
class _ContentImageSectionView extends NewBaseView<ContentDetailViewModel> {
  const _ContentImageSectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<ContentDetailViewModel, List<String>?>(
      selector: (context, vm) => vm.contentImgList,
      builder: (context, contentImgList, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (vm(context).contentImgExist ?? true)
              const SectionTitle(title: '콘텐츠 이미지', setLeftPadding: true),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
              ),
              height: 186,
              child: ListView.separated(
                separatorBuilder: (__, _) => AppSpace.size10,
                padding: const EdgeInsets.only(left: 16),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: contentImgList?.length ?? 4,
                itemBuilder: (context, index) {
                  if (contentImgList.hasData) {
                    final imgItem = contentImgList![index];
                    return KeepAliveView(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: CachedNetworkImage(
                          imageUrl: imgItem.prefixTmdbImgPath,
                          height: 100,
                          width: SizeConfig.to.screenWidth - 32,
                          memCacheWidth:
                              ((SizeConfig.to.screenWidth - 32)* 2).toInt(),
                          fit: BoxFit.fitWidth,
                          placeholder: (context, url) => const SkeletonBox(),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey.withOpacity(0.1),
                            child: const Center(
                              child: Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return SkeletonBox(
                      height: 100,
                      width: SizeConfig.to.screenWidth - 32,
                    );
                  }
                },
              ),
            )
          ],
        );
      },
    );
  }
}

// 기타 정보
class _ElseInfoSectionView extends NewBaseView<ContentDetailViewModel> {
  const _ElseInfoSectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              if (vmS(context,
                  (vm) => vm.passedArgument.contentType == ContentType.movie))
                elseInfoItem(
                    title: '방영일', content: vm(context).releaseDate ?? '-')
              else
                elseInfoItem(
                  title: '방영상태',
                  content: vm(context).contentAirStatus ?? '-',
                ),
              elseInfoItem(
                  title: '총 좋아요 수', content: vmW(context).likesCount ?? '-'),
            ],
          ),
          Row(
            children: <Widget>[
              elseInfoItem(
                title: '총 조회수',
                content: vm(context).totalViewCount ?? '',
              ),
              elseInfoItem(
                title: '영상 업로드일',
                content: vmW(context).youtubeUploadDate ?? '',
              ),
            ],
          ),
        ],
      ),
    );
  }

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

/// 큐레이터
class _CurationSectionView extends NewBaseView<ContentDetailViewModel> {
  const _CurationSectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<ContentDetailViewModel, UserModel?>(
      selector: (context, vm) => vm.curator,
      builder: (context, curator, _) {
        return Padding(
          padding: AppInset.horizontal16,
          child: Row(
            children: <Widget>[
              if (curator != null)
                RoundProfileImg(size: 62, imgUrl: curator.photoUrl)
              else
                const SkeletonBox(
                  width: 62,
                  height: 62,
                  borderRadius: 100,
                ),
              AppSpace.size10,
              if (curator?.displayName.hasData != null)
                Text(
                  curator?.displayName ?? '익명',
                  style: AppTextStyle.headline3,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              else
                const SkeletonBox(
                  height: 22,
                  width: 50,
                  borderRadius: 4,
                ),
            ],
          ),
        );
      },
    );
  }
}

/// 출연진
class _CreditSectionView extends NewBaseView<ContentDetailViewModel> {
  const _CreditSectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<ContentDetailViewModel, List<ContentCreditInfo>?>(
      selector: (context, vm) => vm.contentCreditList,
      builder: (context, creditList, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (creditList?.isNotEmpty ?? true)
              GestureDetector(
                  onTap: () {
                    print(vm(context).contentCreditList?.length);
                  },
                  child: const SectionTitle(title: '출연진', setLeftPadding: true))
            else
              const SizedBox(),
            // 출연진 - PageView Slider
            CarouselSlider.builder(
              itemCount: creditList.hasData ? vm(context).sliderCount : 2,
              options: CarouselOptions(
                height: vm(context).isCreditNotEmpty ?? true ? 224 : 0,
                enableInfiniteScroll: false,
                viewportFraction: 0.93,
              ),
              itemBuilder:
                  (BuildContext context, int parentIndex, int pageViewIndex) {
                /// Top Content Section
                return ListView.separated(
                  separatorBuilder: (__, _) => AppSpace.size16,
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
                            child: const SkeletonBox(
                              borderRadius: 32,
                              height: 62,
                              width: 62,
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
