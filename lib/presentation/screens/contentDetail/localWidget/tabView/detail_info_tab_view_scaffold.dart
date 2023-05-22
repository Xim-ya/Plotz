import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2023.03.27
 *  컨텐츠 상세 스크린 > 정보 탭뷰 Scaffold 레이아웃 위젯
 * */

class ContentInfoTabViewScaffold extends StatelessWidget {
  const ContentInfoTabViewScaffold(
      {Key? key,
      required this.creditSection,
      required this.curatorView,
      required this.elseInfoView,
      required this.contentImgSection,})
      : super(key: key);

  final Widget creditSection;
  final Widget curatorView;
  final Widget elseInfoView;
  final Widget contentImgSection;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        creditSection,
        // 큐레이터 정보
        const SectionTitle(title: '큐레이터', setLeftPadding: true),
        curatorView,
        AppSpace.size40,
        // 기타 정보
        const SectionTitle(title: '기타정보', setLeftPadding: true),
        AppSpace.size10,
        elseInfoView,
        AppSpace.size40,
        contentImgSection,
      ],
    );
  }
}
