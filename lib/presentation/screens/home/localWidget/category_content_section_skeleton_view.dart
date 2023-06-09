import 'package:soon_sak/presentation/common/image/content_poster_item_view.dart';
import 'package:soon_sak/presentation/common/skeleton_box.dart';
import 'package:soon_sak/utilities/index.dart';

class CategoryContentSectionSkeletonView extends StatelessWidget {
  const CategoryContentSectionSkeletonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          // 카테고리 제목
          child: SkeletonBox(
            width: 100,
            height: 18,
          ),
        ),
        AppSpace.size12,
        // 컨텐츠 리스트 슬라이더
        ContentPostSlider(
          height: 180,
          itemCount: 4,
          itemBuilder: (context, index) {
            return ContentPosterItemView.createSkeleton();
          },
        ),
      ],
    );
  }
}
