import 'package:soon_sak/utilities/index.dart';

class ContentsGridView extends StatelessWidget {
  const ContentsGridView({Key? key, required this.contents}) : super(key: key);

  final List<CurationContent> contents;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInset.horizontal16 + AppInset.top20,
      child: contents.isNotEmpty
          ? GridView.builder(
              shrinkWrap: true,
              itemCount: contents.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 34,
                crossAxisSpacing: 8,
                childAspectRatio: 0.5,
              ),
              itemBuilder: (context, index) {
                final item = contents[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RatioContentPostItem(
                      imgUrl: item.posterImgUrl,
                    ),
                    const SizedBox(height: 1),
                    SizedBox(
                      width: 90,
                      child: Text(
                        item.title,
                        style: AppTextStyle.body2,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      SplittedIdAndType.fromOriginId(item.id).type.name,
                      style: AppTextStyle.alert1.copyWith(
                        color: AppColor.lightGrey,
                      ),
                    )
                  ],
                );
              },
            )
          : Center(
              child: Text(
                '관련 큐레이션 내역이 없어요',
                style: AppTextStyle.title1.copyWith(color: AppColor.lightGrey),
              ),
            ),
    );
  }
}
