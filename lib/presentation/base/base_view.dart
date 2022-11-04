import 'package:uppercut_fantube/utilities/index.dart';

/** Created By Ximya - 2022.11.04
 * - [GetView]를 상속 받는 Base Screen 모듈
 * - 해당 모듈에서 [Getx] Controller의 타입을 전달 받고 초기화 시킴.
 * - [BaseScreen] 모듈과 달리 Scaffold 구성되어 있지 않음.
 *   ⚠️ 무분별한 GetView 사용 지양
 *   재사용성을 낮추고 불필요하게 의존성을 높일 수 있음.
 * */

@immutable
abstract class BaseView<T extends BaseViewModel> extends GetView<T> {
  const BaseView({Key? key}) : super(key: key);

  T get vm => controller;

  @override
  Widget build(BuildContext context) {
    return buildView(context);
  }

  @mustCallSuper
  void initViewModel() {
    vm.initialized;
  }

  Widget buildView(BuildContext context);
}

