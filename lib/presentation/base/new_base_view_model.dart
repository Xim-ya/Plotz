import 'package:flutter/cupertino.dart';

abstract class NewBaseViewModel extends ChangeNotifier {
  NewBaseViewModel() {
    onInit();
  }

  bool loading = false;

  @override
  void dispose() {
    super.dispose();
    onDispose();
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
}
