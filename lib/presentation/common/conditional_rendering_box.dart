import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2022.12.17
 *  조건부 렌더링이 필요한 widget이 있을 때 사용하는 모듈
 *  [RxDart]인 경우 부모 위젯이 [Obx]로 감싸져 있어야됨
 * */

class ConditionalRenderingBox extends StatelessWidget {
  const ConditionalRenderingBox({
    Key? key,
    required this.condition,
    required this.onLoadingWidget,
    required this.loadedWidget,

  }) : super(key: key);
  final bool condition; // 조건
  final Widget onLoadingWidget; // 로딩중일 때
  final Widget loadedWidget; // 로드가 되었을 때



  @override
  Widget build(BuildContext context) {
    return condition ? loadedWidget : onLoadingWidget;
  }
}
