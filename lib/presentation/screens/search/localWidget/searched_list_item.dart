import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/domain/model/content/search/searched_content.m.dart';
import 'package:soon_sak/presentation/index.dart';
import 'package:soon_sak/utilities/extensions/cached_img_size_extension.dart';
import 'package:soon_sak/utilities/index.dart';

class SearchListItem extends StatelessWidget {
  const SearchListItem({
    Key? key,
    required this.contentType,
    required this.item,
    required this.onItemClicked,
  }) : super(key: key);

  final MediaType contentType;
  final SearchedContentNew item;
  final VoidCallback onItemClicked;

  @override
  Widget build(BuildContext context) {
    // 컨텐츠 등록 여부 인디케이터 case별 위젯
    Widget caseIndicatorOnTrailing() {
      switch (item.state.value) {
        case RegistrationState.isLoading:
          return const SizedBox(
            height: 12,
            width: 12,
            child: CircularProgressIndicator(
              color: AppColor.darkGrey,
              strokeWidth: 2,
            ),
          );
        case RegistrationState.registered:
          return const SizedBox();
        case RegistrationState.unRegistered:
          return SvgPicture.asset('assets/icons/rounded_exclamation.svg');
      }
    }

    return InkWell(
      onTap: onItemClicked,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // 이미지
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: item.posterImgUrl != null
                ? CachedNetworkImage(
                    fit: BoxFit.cover,
                    height: 120,
                    width: 79,
                    memCacheHeight: 120.cacheSize(context),
                    imageUrl: item.posterImgUrl!.prefixTmdbImgPath,
                    placeholder: (context, url) => const SkeletonBox(),
                  )
                : Container(
                    height: 120,
                    width: 79,
                    color: Colors.grey.withOpacity(0.1),
                    child: const Center(
                      child: Icon(Icons.error),
                    ),
                  ),
          ),
          AppSpace.size8,

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 제목 & 유효 여부 인디케이터
              Row(
                children: <Widget>[
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: SizeConfig.to.screenWidth - 133,
                    ),
                    child: Text(
                      item.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.body3.copyWith(
                        color: item.state.value.isRegistered
                            ? AppColor.main
                            : AppColor.white,
                      ),
                    ),
                  ),
                  AppSpace.size2,
                  caseIndicatorOnTrailing(),
                ],
              ),
              AppSpace.size2,
              // 미디어 타입 & 개봉 및 출시년도
              Text(
                '${item.type.asText} · ${item.releaseDate.hasData ? Formatter.dateToYear(item.releaseDate!) : '미상'}',
                style: AppTextStyle.alert2.copyWith(
                  color: AppColor.gray01,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
