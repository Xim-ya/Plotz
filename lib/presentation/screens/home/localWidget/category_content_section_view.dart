import 'package:soon_sak/utilities/index.dart';

class CategoryContentSectionView extends StatefulWidget {
  const CategoryContentSectionView(
      {Key? key,
        required this.contentSectionData,
        required this.onContentTapped})
      : super(key: key);

  final CategoryContentSection contentSectionData;
  final Function(int) onContentTapped;

  @override
  _CategoryContentSectionViewState createState() =>
      _CategoryContentSectionViewState();
}

class _CategoryContentSectionViewState extends State<CategoryContentSectionView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            widget.contentSectionData.title,
            style: AppTextStyle.headline3,
            maxLines: 1,
            overflow: TextOverflow.fade,
          ),
        ),
        AppSpace.size8,
        ContentPostSlider(
          height: 180,
          itemCount: widget.contentSectionData.contents.length,
          itemBuilder: (context, index) {
            final contentItem = widget.contentSectionData.contents[index];
            return GestureDetector(
              onTap: () {
                widget.onContentTapped(index);
              },
              child: ContentPostItem(imgUrl: contentItem.posterImgUrl),
            );
          },
        ),
      ],
    );
  }
}