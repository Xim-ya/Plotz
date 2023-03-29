import 'package:soon_sak/utilities/index.dart';

/** Edited By Ximya - 2023.03.21
 *  [HomeScreen]의 카테고리 섹션 영역 부분 섹션뷰 -> 각 개별 카테고리 '제목' + '컨텐츠 리스트'
 *  [PagedListView]적용 되어 있는데 리스트뷰의 itemBuilder 리턴 값으로 해당 모듈이 사용됨
 *
 *  아래 코드를 보면 [KeepAliveView]가 적용되어 있음.
 *  이는 불필요헌 리렌더링 방지하기 위해서 [AutomaticKeepAliveClientMixin]로직이 들어간
 *  [KeepAliveView]를 이용한 것이라고 이해할 수 있음
 *
 *  만약 해당 View를 사용하지 않으면
 *  이미 한번 그려진 위젯이더라도
 *  상하 스크롤을 하여 컨텐츠가 화면에 보이지 않은 상태에서
 *  다시 스크롤 포지션이 돌아왔을 때 리렌더링이 되는 현상이 발생함
 *
 * */


class CategoryContentSectionView extends StatelessWidget {
  const CategoryContentSectionView({
    Key? key,
    required this.contentSectionData,
    required this.onContentTapped,
  }) : super(key: key);

  final CategoryContentSection contentSectionData;
  final Function(int) onContentTapped;

  @override
  Widget build(BuildContext context) {
    return KeepAliveView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              contentSectionData.title,
              style: AppTextStyle.headline3,
              maxLines: 1,
              overflow: TextOverflow.fade,
            ),
          ),
          AppSpace.size8,
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
      ),
    );
  }
}
