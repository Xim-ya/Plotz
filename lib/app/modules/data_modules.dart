import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:uppercut_fantube/data/api/tmdb/tmdb_api.dart';
import 'package:uppercut_fantube/data/dataSource/content/content_data_source.dart';
import 'package:uppercut_fantube/data/dataSource/content/content_data_source_impl.dart';
import 'package:uppercut_fantube/data/dataSource/tmdb/tmdb_data_source.dart';
import 'package:uppercut_fantube/data/dataSource/tmdb/tmdb_data_source_impl.dart';
import 'package:uppercut_fantube/domain/repository/content/content_repository.dart';
import 'package:uppercut_fantube/domain/repository/content/content_repository_impl.dart';
import 'package:uppercut_fantube/domain/repository/tmdb/tmdb_repository.dart';
import 'package:uppercut_fantube/domain/repository/tmdb/tmdb_repository_impl.dart';

abstract class DataModules {
  DataModules._();

  static void getDependencies() {
    /* Dio */
    Get.lazyPut(() => Dio(), fenix: true);

    /* Content */
    Get.lazyPut<ContentDataSource>(() => ContentDataSourceImpl());
    Get.lazyPut<ContentRepository>(() => ContentRepositoryImpl(Get.find()),
        fenix: true);

    /* Tmdb */
    Get.lazyPut(() => TmdbApi(Get.find()), fenix: true);
    Get.lazyPut<TmdbRepository>(() => TmdbRepositoryImpl(Get.find()),
        fenix: true);
    Get.lazyPut(() => TmdbApi(Get.find()), fenix: true);
    Get.lazyPut<TmdbDataSource>(() => TmdbDataSourceImpl(Get.find()), fenix: true);
  }
}
