import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/presentation/index.dart';
import 'package:soon_sak/utilities/index.dart';

class MyWatchHistorySlider extends BaseView<MyPageViewModel> {
  const MyWatchHistorySlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UserWatchHistoryItem>?>(
      stream: vm(context).watchHistorySub.stream,
      builder: (context, snapshot) {
        final items = snapshot.data;
        return items.hasData && items!.isEmpty
            ? Container(
                alignment: Alignment.center,
                height: 160,
                child: Text(
                  '앗! 아직 시청기록이 없으시네요.\n플로츠에서 다양한 콘텐츠를 즐겨보세요!',
                  style: AppTextStyle.body3.copyWith(color: AppColor.gray03),
                  textAlign: TextAlign.center,
                ),
              )
            : ContentPostSlider(
                height: 160,
                itemCount: items?.length ?? 5,
                itemBuilder: (BuildContext context, int index) {
                  final item = items?[index];
                  if (item.hasData) {
                    return GestureDetector(
                      onTap: () {
                        final arg = ContentArgumentFormat(
                          originId: item.originId,
                          contentId:
                              SplittedIdAndType.fromOriginId(item.originId).id,
                          contentType:
                              SplittedIdAndType.fromOriginId(item.originId)
                                  .type,
                          posterImgUrl: item.posterImgUrl,
                          title: item.title,
                        );
                        vm(context).routeToContentDetail(arg);
                      },
                      child: ContentPosterItemView(
                        imgUrl: item?.posterImgUrl,
                        title: item!.title,
                      ),
                    );
                  } else {
                    return ContentPosterItemView.createSkeleton();
                  }
                },
              );
      },
    );
  }
}
