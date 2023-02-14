import 'package:dio/dio.dart';
import 'package:soon_sak/data/dataSource/auth/auth_data_source.dart';
import 'package:soon_sak/data/dataSource/auth/auth_data_source_impl.dart';
import 'package:soon_sak/data/dataSource/staticContent/static_content_data_source_impl.dart';
import 'package:soon_sak/data/dto/content/content_api.dart';
import 'package:soon_sak/data/dto/content/content_api_impl.dart';
import 'package:soon_sak/data/firebase/app_fire_store.dart';
import 'package:soon_sak/data/repository/auth/auth_repository.dart';
import 'package:soon_sak/data/repository/auth/auth_repository_impl.dart';
import 'package:soon_sak/data/repository/staticContent/static_content_repository_impl.dart';
import 'package:soon_sak/data/repository/youtube/youtube_repository_impl.dart';
import 'package:soon_sak/utilities/index.dart';

abstract class DataModules {
  DataModules._();

  static void getDependencies() {
    /* Auth */
    Get.lazyPut<AuthDataSource>(() => AuthDataSourceImpl(), fenix: true);
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find()),
        fenix: true);

    /* Static Content */
    Get.lazyPut(() => StaticContentApi(Get.find()), fenix: true);
    Get.lazyPut<StaticContentDataSource>(
        () => StaticContentDataSourceImpl(Get.find()),
        fenix: true);
    Get.lazyPut<StaticContentRepository>(
        () => StaticContentRepositoryImpl(Get.find()),
        fenix: true);

    /* Dio */
    Get.lazyPut(() => Dio(), fenix: true);

    // Get.put<Dio>(AppDio.getInstance(), permanent: true);
    /* FireStore */
    Get.lazyPut(() => AppFireStore(), fenix: true);

    /* Content */
    Get.lazyPut<ContentApi>(() => ContentApiImpl(), fenix: true);
    Get.lazyPut<ContentDataSource>(() => ContentDataSourceImpl(Get.find()),
        fenix: true);
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
