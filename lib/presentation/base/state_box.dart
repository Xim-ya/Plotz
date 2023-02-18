import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2023.02.18
 *  [GetBuilder] 모듈
 *  해당 모듈을 사용할 때 widget와 GetxController 타입만 넘겨
 *  코드를 직관적으로 표현할 수 있음 (유지보수성과 가독성을 고려)
 *  (물론 추가적인 레이어가 생성됨으로 매우 미약하지만 성능에 영향을 끼칠 수 있음)
 *
 *  [GetxController] 의 동적 타입을 받아 인스턴스를 추출하여
 *  GetBuilder 속성에 전달하는 형태
 *
 *  Widget 뿐만 아니라 builder[Widget Function(dynamic)]을 활용하기도 함.
 *  StateBox의 자식 위젯을 삼항 연산자로 적을 경우 가독성이 떨어짐
 *  이때는 builder를 사용하여 if else 구문을 사용할 수 있도록 함.
 *
 *  assert 조건으로 child 또는 builder 둘중 하나만을 사용해야된 것을 강제함
 * */

class StateBox<T extends GetxController> extends StatelessWidget {
  final Widget? child;
  final Widget Function(dynamic)? builder;

  const StateBox({super.key, this.child, this.builder})
      : assert(child == null || builder == null),
        assert(!(child != null && builder != null));

  @override
  Widget build(BuildContext context) {
    return GetBuilder<T>(
      builder: (_) {
        if (child.hasData) {
          return child!;
        } else {
          return builder!(dynamic);
        }
      },
    );
  }
}

