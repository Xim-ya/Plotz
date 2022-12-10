import 'package:uppercut_fantube/domain/model/content/tv_content_credit_info.dart';
import 'package:uppercut_fantube/utilities/extensions/check_null_state_extension.dart';
import 'package:uppercut_fantube/utilities/extensions/tmdb_img_path_extension.dart';
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
        // 5
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
                          imgUrl: creditItem.profilePath?.returnWithTmdbImgPath,
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
                  elseInfoItem(title: '방영상태', content: '종영'),
                  elseInfoItem(title: '총 좋아요 수', content: '1.7천'),
                ],
              ),
              Row(
                children: <Widget>[
                  elseInfoItem(title: '총 조회수', content: '81만'),
                  elseInfoItem(title: '영상 업로드일', content: '2022.11.13'),
                ],
              ),
            ],
          ),
        ),
        AppSpace.size40,
        const SectionTitle(title: '컨텐츠 이미지', setLeftPadding: true),
        SizedBox(
          height: 186,
          child: ListView.separated(
              separatorBuilder: (__, _) => AppSpace.size10,
              padding: const EdgeInsets.only(left: 16),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (context, index) {
                return CachedNetworkImage(
                  fit: BoxFit.contain,
                  imageUrl:
                      'https://image.tmdb.org/t/p/w1280/euYz4adiSHH0GE3YnTeh3uLfBvL.jpg',
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
        )
      ],
    );
  }

  // 기타정보 > 리스트 아이템
  Expanded elseInfoItem({required String title, required String content}) {
    return Expanded(
      child: Text.rich(
        TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: title,
              style: AppTextStyle.body2.copyWith(color: Colors.white),
            ),
            TextSpan(
              text: ' : $content',
              style: AppTextStyle.body2,
            ),
          ],
        ),
      ),
    );
  }
}
