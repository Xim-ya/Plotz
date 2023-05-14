import 'package:flutter/cupertino.dart';


abstract class NewBaseViewModel extends ChangeNotifier {
  NewBaseViewModel() {
    onInit();
  }

  @override
  void dispose() {
    super.dispose();
    onDispose();
  }

  @protected
  void onInit() {}

  @protected
  void onDispose() {}
}
