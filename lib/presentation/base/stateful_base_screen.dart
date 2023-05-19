import 'package:cupertino_will_pop_scope/cupertino_will_pop_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:soon_sak/app/config/color_config.dart';
import 'package:soon_sak/presentation/base/new_base_view_model.dart';

@immutable
abstract class SmapleBaseScreen<T extends NewBaseViewModel>
    extends StatefulWidget {
  const SmapleBaseScreen({Key? key}) : super(key: key);

  @override
  _SmapleBaseScreenState<T> createState() => _SmapleBaseScreenState<T>();

  Widget buildScreen(BuildContext context);

  PreferredSizeWidget? buildAppBar(BuildContext context);

  bool get wrapWithSafeArea => true;

  bool get setLazyInit => false;

  bool get setBottomSafeArea => true;

  bool get setTopSafeArea => true;

  T createViewModel(BuildContext context);
}

class _SmapleBaseScreenState<T extends NewBaseViewModel>
    extends State<SmapleBaseScreen<T>> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: widget.createViewModel,
      lazy: widget.setLazyInit,
      builder: (BuildContext context, Widget? child) {
        return ConditionalWillPopScope(
          shouldAddCallback: preventSwipeBack,
          onWillPop: () async {
            return false;
          },
          child: Container(
            color: unSafeAreaColor,
            child: widget.wrapWithSafeArea
                ? SafeArea(
              bottom: widget.setBottomSafeArea,
              child: _buildScaffold(context),
            )
                : _buildScaffold(context),
          ),
        );
      },
    );
  }

  Widget _buildScaffold(BuildContext context) {
    return Scaffold(
      extendBody: extendBodyBehindAppBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: widget.buildAppBar(context),
      body: widget.buildScreen(context),
      backgroundColor: screenBackgroundColor,
      bottomNavigationBar: buildBottomNavigationBar(context),
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButton: buildFloatingActionButton(context),
    );
  }

  @protected
  Color? get unSafeAreaColor => AppColor.black;

  @protected
  bool get resizeToAvoidBottomInset => true;

  @protected
  Widget? buildFloatingActionButton(BuildContext context) => null;

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
  bool get setLazyInit => false;

  @protected
  bool get setBottomSafeArea => true;

  @protected
  bool get setTopSafeArea => true;

  T vm(BuildContext context) => Provider.of<T>(context, listen: false);

  T vmR(BuildContext context) => context.read<T>();

  T vmW(BuildContext context) => context.watch<T>();

  S vmS<S>(BuildContext context, S Function(T) selector) {
    return context.select((T value) => selector(value));
  }
}
