import 'package:uppercut_fantube/utilities/index.dart';

abstract class BaseSingleDataModel {
  Future<void> fetchData();
  bool get isLoaded;

}
