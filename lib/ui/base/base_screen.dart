import 'package:uppercut_fantube/utilities/index.dart';

@immutable
abstract class BaseScreen<T extends BaseViewModel> extends GetView<T> {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Getx Controller(VM) 초기화
    initViewModel();

    return ConditionalWillPopScope(
      shouldAddCallback: false,
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
      resizeToAvoidBottomInset: true,
      appBar: buildAppBar(context),
      body: buildBody(context),
      backgroundColor: Colors.red,
      bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }

  @protected
  Color? get screenBackgroundColor => Colors.red;

  @protected
  Widget? buildBottomNavigationBar(BuildContext context) => null;

  @protected
  Widget buildBody(BuildContext context);

  @protected
  PreferredSizeWidget? buildAppBar(BuildContext context) => null;

  @protected
  bool get wrapWithSafeArea => true;

  @mustCallSuper
  void initViewModel() {
    vm.initialized;
  }

  @protected
  T get vm => controller;
}
