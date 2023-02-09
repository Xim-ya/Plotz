import 'package:dio/dio.dart';
import 'package:uppercut_fantube/data/dataSource/auth/auth_data_source.dart';
import 'package:uppercut_fantube/data/dataSource/auth/auth_data_source_impl.dart';
import 'package:uppercut_fantube/data/dataSource/staticContent/static_content_data_source.dart';
import 'package:uppercut_fantube/data/dataSource/staticContent/static_content_data_source_impl.dart';
import 'package:uppercut_fantube/data/dto/staticContent/static_content_api.dart';
import 'package:uppercut_fantube/data/repository/auth/auth_repository.dart';
import 'package:uppercut_fantube/data/repository/auth/auth_repository_impl.dart';
import 'package:uppercut_fantube/data/repository/staticContent/static_content_repository.dart';
import 'package:uppercut_fantube/data/repository/staticContent/static_content_repository_impl.dart';
import 'package:uppercut_fantube/data/repository/youtube/youtube_repository_impl.dart';
import 'package:uppercut_fantube/utilities/index.dart';

abstract class DataModules {
  DataModules._();

  static void getDependencies() {
    /* Auth */
    Get.lazyPut<AuthDataSource>(() => AuthDataSourceImpl(), fenix: true);
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find()),
        fenix: true);

    /* Static Content */
    Get.lazyPut(() => StaticContentApi(Get.find()), fenix: true);
    Get.lazyPut<StaticContentDataSource>(() =>  StaticContentDataSourceImpl(Get.find()));
    Get.lazyPut<StaticContentRepository>(() => StaticContentRepositoryImpl(Get.find()));


    /* Dio */
    Get.lazyPut(() => Dio(), fenix: true);

    /* Content */
    Get.lazyPut<ContentDataSource>(() => ContentDataSourceImpl(), fenix: true);
    Get.lazyPut<ContentRepository>(() => ContentRepositoryImpl(Get.find()),
        fenix: true);

    /* Tmdb */
    Get.lazyPut(() => TmdbApi(Get.find()), fenix: true);
    Get.lazyPut<TmdbRepository>(() => TmdbRepositoryImpl(Get.find()),
        fenix: true);
    Get.lazyPut(() => TmdbApi(Get.find()), fenix: true);
    Get.lazyPut<TmdbDataSource>(() => TmdbDataSourceImpl(Get.find()),
        fenix: true);

    /* Youtube */
    Get.lazyPut<YoutubeRepository>(() => YoutubeRepositoryImpl(), fenix: true);
  }
}
