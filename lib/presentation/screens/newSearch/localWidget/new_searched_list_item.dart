import 'package:soon_sak/utilities/index.dart';

class NewSearchedListItem extends StatelessWidget {
  const NewSearchedListItem(
      {Key? key,
      required this.contentType,
      required this.item,
      required this.onItemClicked})
      : super(key: key);

  final ContentType contentType;
  final SearchedContent item;
  final VoidCallback onItemClicked;

  @override
  Widget build(BuildContext context) {
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
                size: 40,
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

    return InkWell(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        bottomLeft: Radius.circular(12),
      ),
      onTap: onItemClicked,
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
                        : contentType.isTv
                            ? '방영일 확인 불가'
                            : '개봉일 확인 불가',
                    style:
                        AppTextStyle.body2.copyWith(color: AppColor.lightGrey),
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
  }
}
