import 'package:soon_sak/utilities/index.dart';

abstract class BaseSingleDataModel {
  Future<void> fetchData();
  bool get isLoaded;

}
