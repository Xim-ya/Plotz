import 'package:soon_sak/domain/model/content/home/category_content_collection_model.dart';
import 'package:soon_sak/utilities/index.dart';

class CategoryContentSectionView extends StatelessWidget {
  const CategoryContentSectionView(
      {Key? key,
      required this.contentSectionData,
      required this.onContentTapped})
      : super(key: key);

  final CategoryContentSection contentSectionData;
  final Function(int) onContentTapped;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          // 카테고리 제목
          child: Text(
            contentSectionData.title,
            style: AppTextStyle.headline3,
            maxLines: 1,
            overflow: TextOverflow.fade,
          ),
        ),
        AppSpace.size8,
        // 컨텐츠 리스트 슬라이더
        ContentPostSlider(
          height: 180,
          itemCount: contentSectionData.contents.length,
          itemBuilder: (context, index) {
            final contentItem = contentSectionData.contents[index];
            return GestureDetector(
              onTap: () {
                onContentTapped(index);
              },
              child: ContentPostItem(imgUrl: contentItem.posterImgUrl),
            );
          },
        ),
      ],
    );
  }
}
