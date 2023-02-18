import 'package:flutter/material.dart';
import 'package:get/get.dart';

/** Created By Ximya - 2023.02.18
 *  [GetBuilder] 모듈
 *  해당 모듈을 사용할 때 builder와 GetxController 타입만 넘겨
 *  코드를 직관적으로 표현할 수 있음 (유지보수성과 가독성을 고려)
 *  (물론 추가적인 레이어가 생성됨으로 매우 미약하지만 성능에 영향을 끼칠 수 있음)
 *
 *  [GetxController] 의 동적 타입을 받아 인스턴스를 추출하여
 *  GetBuilder 속성에 전달하는 형태
 * */

class StateBox<T extends GetxController> extends StatelessWidget {
  final Widget child;

  const StateBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<T>(
      builder: (_) {
        return child;
      },
    );
  }
}
