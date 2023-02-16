import 'package:soon_sak/utilities/index.dart';

class RegisterVideoLinkPageViewScaffold extends StatelessWidget {
  const RegisterVideoLinkPageViewScaffold({
    Key? key,
    required this.onBackgroundLayerTapped,
    required this.leadingTitle,
    required this.searchBar,
    required this.pasteIntroductionView,
    required this.bottomFixedStepBtn,
  }) : super(key: key);

  final VoidCallback onBackgroundLayerTapped;
  final Widget leadingTitle;
  final Widget searchBar;
  final Widget pasteIntroductionView;
  final Widget bottomFixedStepBtn;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onBackgroundLayerTapped,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Padding(
            padding: AppInset.horizontal16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // 리딩 문구
                leadingTitle,

                // 검색 창
                searchBar,
              ],
            ),
          ),

          // 주소 복사 방법 예시 이미지
          pasteIntroductionView,

          // 하단 고정 버튼
          bottomFixedStepBtn,
        ],
      ),
    );
  }
}
