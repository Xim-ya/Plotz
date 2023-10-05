import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/domain/model/content/myPage/requested_content.m.dart';
import 'package:soon_sak/presentation/index.dart';
import 'package:soon_sak/utilities/index.dart';

class RequestedContentItemView extends StatelessWidget {
  const RequestedContentItemView(
      {super.key,
      required this.content,
      required this.onContentTapped,
      this.isFetched = true});

  final RequestedContent? content;
  final VoidCallback? onContentTapped;
  final bool isFetched;

  factory RequestedContentItemView.createSkeleton() => RequestedContentItemView(
      content: null, onContentTapped: null, isFetched: false);

  @override
  Widget build(BuildContext context) {
    if (isFetched == true) {
      final item = content!;
      return InkWell(
        enableFeedback: false,
        onTap: onContentTapped,
        child: Stack(
          children: [
            Row(
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
                    // 제목 &
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: SizeConfig.to.screenWidth - 133,
                      ),
                      child: Text(
                        item.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.body3.copyWith(
                          color: AppColor.white,
                        ),
                      ),
                    ),
                    AppSpace.size2,
                    // 미디어 타입 & 개봉 및 출시년도
                    Text(
                      '${item.contentType.asText} · ${item.hasData ? Formatter.dateToYear(item.releasedDate!) : '미상'}',
                      style: AppTextStyle.alert2.copyWith(
                        color: AppColor.gray01,
                      ),
                    )
                  ],
                ),
              ],
            ),
            if (item.status.key == 2)
              Positioned(
                right: 0,
                bottom: 0,
                child: Text(
                  item.status.desc ?? '',
                  style: AppTextStyle.alert2.copyWith(
                    color: AppColor.gray04,
                  ),
                ),
              ),
          ],
        ),
      );
    } else {
      return Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // 이미지
              const SkeletonBox(
                height: 120,
                width: 79,
              ),

              AppSpace.size8,

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 제목 &
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: SizeConfig.to.screenWidth - 133,
                    ),
                    child: const SkeletonBox(
                      height: 16,
                      width: 100,
                      padding: AppInset.vertical2,
                    ),
                  ),
                  AppSpace.size2,
                  // 미디어 타입 & 개봉 및 출시년도
                  const Row(
                    children: [
                      SkeletonBox(
                        height: 14,
                        width: 40,
                        padding: AppInset.vertical2,
                      ),
                      AppSpace.size4,
                      SkeletonBox(
                        height: 14,
                        width: 40,
                        padding: AppInset.vertical2,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      );
    }
  }
}
