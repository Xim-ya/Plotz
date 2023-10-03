import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/domain/enum/requested_content_status.dart';
import 'package:soon_sak/domain/model/content/myPage/requested_content.m.dart';
import 'package:soon_sak/presentation/base/base_view.dart';
import 'package:soon_sak/presentation/common/skeleton_box.dart';
import 'package:soon_sak/presentation/screens/requested_content/requested_content_board_view_model.dart';
import 'package:soon_sak/utilities/data_status.dart';
import 'package:soon_sak/utilities/index.dart';

class RequestedContentStatusListView
    extends BaseView<RequestedContentBoardViewModel> {
  const RequestedContentStatusListView(this.statusKey, {Key? key})
      : super(key: key);

  final int statusKey;

  @override
  Widget build(BuildContext context) {
    return Selector<RequestedContentBoardViewModel, Ds<List<RequestedContent>>>(
      selector: (context, vm) => vm.getContentsByKey(statusKey),
      builder: (context, list, _) {
        if (list.cycle.isFailed) {
          return Center(
            child: Text(
              '오류가 발생했어요',
              style: AppTextStyle.title1,
            ),
          );
        }

        if (list.cycle.isFetched && list.value!.isEmpty) {
          return Center(
            child: Text(
              '${RequestedContentStatus.fromKeyValue(key: statusKey, pendingReason: null).text}된 콘텐츠가 없어요',
              style: AppTextStyle.title1,
            ),
          );
        }

        return ListView.separated(
          padding: AppInset.horizontal16 + AppInset.top24 + AppInset.bottom36,
          separatorBuilder: (_, __) => AppSpace.size16,
          itemCount: vmW(context)
                  .requestedContentCollection[statusKey]
                  .value
                  ?.length ??
              0,
          itemBuilder: (context, index) {
            if (list.cycle.isLoadingOrInitial) {
              return GestureDetector(
                onTap: () {
                  print(vmR(context)
                          .requestedContentCollection[0]
                          .value
                          ?.length ??
                      0);
                },
                child: Text(
                  'skeleton',
                  style: AppTextStyle.title1,
                ),
              );
            }

            final item = list.value![index];

            return InkWell(
              onTap: () {},
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
                                placeholder: (context, url) =>
                                    const SkeletonBox(),
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
          },
        );
      },
    );
  }
}
