import 'package:dio/dio.dart';
import 'package:uppercut_fantube/data/repository/youtube/youtube_repository_impl.dart';
import 'package:uppercut_fantube/utilities/index.dart';


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
    Get.lazyPut<TmdbDataSource>(() => TmdbDataSourceImpl(Get.find()),
        fenix: true);
    
    /* Youtube */
    Get.lazyPut<YoutubeRepository>(() => YoutubeRepositoryImpl(), fenix: true);
  }
}
