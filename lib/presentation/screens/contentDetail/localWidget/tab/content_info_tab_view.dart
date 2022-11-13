import 'package:uppercut_fantube/utilities/index.dart';

/** Created By Ximya - 2022.11.13
 *  컨텐츠 상세 스크린 > 정보 탭뷰 위젯
 * */

class ContentInfoTabView extends StatelessWidget {
  const ContentInfoTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SectionTitle(title: '출연진', setLeftPadding: true),
        // 출연진 - PageView Slider
        CarouselSlider.builder(
          itemCount: 3,
          options: CarouselOptions(
            height: 224,
            enableInfiniteScroll: false,
            viewportFraction: 0.93,
          ),
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) {
            /// Top Content Section
            return ListView.separated(
              separatorBuilder: (__, _) => AppSpace.size16,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Row(
                  children: <Widget>[
                    const RoundProfileImg(
                      size: 62,
                      imgUrl:
                          'https://yt3.ggpht.com/ytc/AMLnZu9mx97jp2uus8qYKYO7gROx18AWIzQprpRdfLIirP19g4qk25l5_ulscs2AWIte2FTnWYE=s48-c-k-c0x00ffffff-no-rj',
                    ),
                    AppSpace.size14,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '심야',
                          style:
                              AppTextStyle.body1.copyWith(color: Colors.white),
                        ),
                        Text('출연진', style: AppTextStyle.body1),
                      ],
                    ),
                  ],
                );
              },
            );
          },
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
            separatorBuilder: (__, _ ) => AppSpace.size10,
              padding: const EdgeInsets.only(left: 16),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (context ,index) {return  CachedNetworkImage(
                fit: BoxFit.contain,
                imageUrl: 'https://image.tmdb.org/t/p/w1280/euYz4adiSHH0GE3YnTeh3uLfBvL.jpg',
                height: 100,
                width: SizeConfig.to.screenWidth - 32,
                imageBuilder: (context, imageProvider) =>
                    Container(
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
              );} ),
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
                          style: AppTextStyle.body2
                              .copyWith(color: Colors.white),
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
