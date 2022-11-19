import 'package:get/get.dart';
import 'package:uppercut_fantube/data/dataSource/content/content_data_source.dart';
import 'package:uppercut_fantube/data/dataSource/content/content_data_source_impl.dart';

abstract class DataModules {
  DataModules._();

  static void getDependencies() {
    /* Content */
    Get.lazyPut<ContentDataSource>(() => ContentDataSourceImpl());
  }
}
