import 'package:soon_sak/utilities/index_prev.dart';

abstract class BaseSingleDataModel {
  Future<void> fetchData();
  bool get isLoaded;

}
