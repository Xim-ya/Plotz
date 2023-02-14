import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2022.11.04
 * - [GetView]를 상속 받는 Base Screen 모듈
 * - 해당 모듈에서 [Getx] Controller의 타입을 전달 받고 초기화 시킴.
 * - 기본적인 [Scaffold] 형태를 기본으로 함
 * - [ConditionalWillPopScope]를 적용 하여 Swipe back 로직 추가
 *   - [preventSwipeBack] 변수를 통해 swip back 동작 여부를 결정
 *   - ios Android 플랫폼에 따라 Swipe back gesture 동작을 다르게 함.
 * */

@immutable
abstract class BaseScreen<T extends BaseViewModel> extends GetView<T> {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Getx Controller(VM) 초기화
    initViewModel();

    return ConditionalWillPopScope(
      shouldAddCallback: preventSwipeBack,
      onWillPop: () async {
        return false;
      },
      child: wrapWithSafeArea
          ? SafeArea(child: _buildScaffold(context))
          : _buildScaffold(context),
    );
  }

  Widget _buildScaffold(BuildContext context) {
    return Scaffold(
      extendBody: extendBodyBehindAppBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: buildAppBar(context),
      body: buildScreen(context),
      backgroundColor: screenBackgroundColor,
      bottomNavigationBar: buildBottomNavigationBar(context),
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButton: buildFloatingActionButton,
    );
  }

  @protected
  bool get resizeToAvoidBottomInset => true;

  @protected
  Widget? get buildFloatingActionButton => null;

  @protected
  FloatingActionButtonLocation? get floatingActionButtonLocation => null;

  @protected
  bool get extendBodyBehindAppBar => false;

  @protected
  bool get preventSwipeBack => false;

  @protected
  Color? get screenBackgroundColor => AppColor.black;

  @protected
  Widget? buildBottomNavigationBar(BuildContext context) => null;

  @protected
  Widget buildScreen(BuildContext context);

  @protected
  PreferredSizeWidget? buildAppBar(BuildContext context) => null;

  @protected
  bool get wrapWithSafeArea => true;

  @protected
  bool get setBottomSafeArea => true;

  @protected
  bool get setTopSafeArea => true;

  @mustCallSuper
  void initViewModel() {
    vm.initialized;
  }

  @protected
  T get vm => controller;
}
