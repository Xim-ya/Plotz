import 'package:soon_sak/presentation/common/skeleton_box.dart';
import 'package:soon_sak/utilities/index.dart';

class SearchedContentItemBtn extends StatelessWidget {
  const SearchedContentItemBtn({
    Key? key,
    required this.title,
    required this.posterImgUrl,
    required this.releaseDate,
    required this.contentType,
    required this.isSelected,
    required this.onBtnTap,
  }) : super(key: key);

  final String? title;
  final String? posterImgUrl;
  final String? releaseDate;
  final ContentType contentType;
  final VoidCallback onBtnTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12),
        bottomLeft: Radius.circular(12),
      ),
      child: MaterialButton(
        padding: EdgeInsets.zero,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        key: key,
        onPressed: onBtnTap,
        child: Row(
          children: <Widget>[
            // 컨텐츠 포스터 이미지
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      memCacheWidth: 270,
                      imageUrl: posterImgUrl?.prefixTmdbImgPath ?? '',
                      placeholder: (context, url) => const SkeletonBox(),
                      errorWidget: (context, url, error) => Container(
                        color: AppColor.darkGrey,
                        child: const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                if (isSelected)
                  Positioned(
                    child: SvgPicture.asset('assets/icons/check_round.svg'),
                  )
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
                      style: AppTextStyle.body2
                          .copyWith(color: AppColor.lightGrey),
                    ),

                  AppSpace.size2,
                  // 등록 여부 Indicator
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
