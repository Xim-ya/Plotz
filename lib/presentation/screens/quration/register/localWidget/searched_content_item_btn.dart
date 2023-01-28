import 'package:uppercut_fantube/utilities/index.dart';

class SearchedContentItemBtn extends StatelessWidget {
  const SearchedContentItemBtn({Key? key, required this.title, required this.posterImgUrl, required this.releaseDate, required this.contentType}) : super(key: key);

  final String? title;
  final String? posterImgUrl;
  final String? releaseDate;
  final ContentType contentType;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        bottomLeft: Radius.circular(12),
      ),
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
                    imageUrl:
                        posterImgUrl?.prefixTmdbImgPath ??
                            '',
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
                    title ?? '제목 없음',
                    style: AppTextStyle.title1,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                AppSpace.size2,

                // 개봉 & 첫 방영일
                if (releaseDate != null || releaseDate != '')
                  Text(
                    releaseDate != null
                        ? Formatter.dateToyyMMdd(releaseDate!)
                        : contentType.isTv
                        ? '방영일 확인 불가'
                        : '개봉일 확인 불가',
                    style:
                    AppTextStyle.body2.copyWith(color: AppColor.lightGrey),
                  ),

                AppSpace.size2,
                // 등록 여부 Indicator
              ],
            ),
          ),
        ],
      ),
    );
  }
}
