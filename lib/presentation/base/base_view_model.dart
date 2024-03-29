import 'package:flutter/cupertino.dart';
import 'package:soon_sak/app/di/locator/locator.dart';
import 'package:soon_sak/domain/enum/tab_loading_state_enum.dart';

abstract class BaseViewModel extends ChangeNotifier {
  BaseViewModel() {
    onInit();
  }

  bool loading = false;
  ViewModelLoadingState loadingState = ViewModelLoadingState.initState;
  late BuildContext context;

  void safeUpdate<T extends BaseViewModel>() {
    if (locator.isRegistered<T>()) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    onDispose();
    super.dispose();
  }

  @protected
  void onInit() {}

  @protected
  void onReady() {
    Future.delayed(Duration.zero);
  }

  @protected
  void onDispose() {}

  Future<void> delayedUntilMount() async {
    await Future.delayed(Duration.zero);
  }

  void initContext(BuildContext contextArg) {
    context = contextArg;
  }
}
