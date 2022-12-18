import 'package:uppercut_fantube/presentation/common/skeleton_box.dart';
import 'package:uppercut_fantube/utilities/index.dart';

/** Created By Ximya - 2022.11.13
 *  컨텐츠 상세 스크린 > 정보 탭뷰 위젯
 * */

class ContentInfoTabView extends BaseView<ContentDetailViewModel> {
  const ContentInfoTabView({Key? key}) : super(key: key);

  @override
  Widget buildView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SectionTitle(title: '출연진', setLeftPadding: true),
        // 출연진 - PageView Slider
        Obx(
          () => CarouselSlider.builder(
            itemCount: vm.contentCreditList.hasData ? vm.sliderCount : 2,
            options: CarouselOptions(
              height: 224,
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
                              decoration: BoxDecoration(shape: BoxShape.circle),
                            ),
                          ),
                        ),
                        AppSpace.size14,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Shimmer(
                              color: AppColor.mixedWhite,
                              child: Container(
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
        AppSpace.size40,

        // 채널정보
        const SectionTitle(title: '채널', setLeftPadding: true),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  // 채널 프로필 이미지
                  if (vm.channelImgUrl.hasData)
                    RoundProfileImg(
                      size: 62,
                      imgUrl: vm.channelImgUrl,
                    )
                  else
                    const SkeletonBox(
                      width: 62,
                      height: 62,
                      borderRadius: 100,
                    ),
                  AppSpace.size10,
                  // 채널명
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      if (vm.channelName.hasData)
                        Text(
                          vm.channelName!,
                          style: AppTextStyle.headline3,
                        )
                      else ...[
                        const SkeletonBox(
                          width: 80,
                          height: 20,
                        ),
                        AppSpace.size2,
                      ],
                      if (vm.subscriberCount.hasData &&
                          vm.totalVideoCount.hasData)
                        Text(
                          '구독자 ${vm.subscriberCount}명 · 총 조회수 ${vm.totalVideoCount}',
                          style: AppTextStyle.body1
                              .copyWith(color: AppColor.lightGrey),
                        )
                      else
                        const SkeletonBox(
                          width: 180,
                          height: 22,
                        ),
                    ],
                  ),
                ],
              ),
              AppSpace.size8,
              // 채널 설명
              if (vm.channelDescription.hasData)
                Text(
                  vm.channelDescription!,
                  style: AppTextStyle.body2,
                )
              else
                const SkeletonBox(
                  width: double.infinity,
                  height: 18,
                ),
            ],
          ),
        ),

        AppSpace.size40,
        // 기타 정보
        const SectionTitle(title: '기타정보', setLeftPadding: true),
        AppSpace.size10,
        Container(
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
                  elseInfoItem(
                      title: '총 좋아요 수', content: vm.totalViewCount ?? '-'),
                ],
              ),
              Row(
                children: <Widget>[
                  elseInfoItem(title: '총 조회수', content: vm.likesCount ?? ''),
                  elseInfoItem(
                      title: '영상 업로드일', content: vm.youtubeUploadDate ?? ''),
                ],
              ),
            ],
          ),
        ),
        AppSpace.size40,
        const SectionTitle(title: '컨텐츠 이미지', setLeftPadding: true),
        SizedBox(
            height: 186,
            child: Obx(
              () => ListView.separated(
                  separatorBuilder: (__, _) => AppSpace.size10,
                  padding: const EdgeInsets.only(left: 16),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: vm.contentImgUrlList?.length ?? 0,
                  itemBuilder: (context, index) {
                    final imgItem = vm.contentImgUrlList![index];
                    return CachedNetworkImage(
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
                    );
                  }),
            ))
      ],
    );
  }

  // 기타정보 > 리스트 아이템
  Expanded elseInfoItem({required String title, required String content}) {
    return Expanded(
      child: Row(
        children: <Widget>[
          Text(
            title,
            style: AppTextStyle.body2.copyWith(color: Colors.white),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          Text(
            ' : $content',
            style: AppTextStyle.body2.copyWith(color: Colors.white),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
