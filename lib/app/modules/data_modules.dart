import 'package:dio/dio.dart';
import 'package:soon_sak/utilities/index.dart';

abstract class DataModules {
  DataModules._();

  static void getDependencies() {
    /* Youtube */
    Get.lazyPut<YoutubeApi>(() => YoutubeApiImpl(), fenix: true);
    Get.lazyPut<YoutubeDataSource>(() => YoutubeDataSourceImpl(Get.find()),
        fenix: true);

    /* Auth */
    Get.lazyPut<AuthApi>(() => AuthApiImpl(), fenix: true);
    Get.lazyPut<AuthDataSource>(() => AuthDataSourceImpl(Get.find()),
        fenix: true);
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find()),
        fenix: true);

    /* User */
    Get.lazyPut<UserApi>(() => UserApiImpl(), fenix: true);
    Get.lazyPut<UserDataSource>(() => UserDataSourceImpl(Get.find()),
        fenix: true);
    Get.lazyPut<UserRepository>(() => UserRepositoryImpl(Get.find()),
        fenix: true);

    /* Static Content */
    Get.lazyPut<StaticContentApi>(
        () => StaticContentApiImpl(Get.find<Dio>()));
    Get.lazyPut<StaticContentDataSource>(
        () => StaticContentDataSourceImpl(Get.find(), Get.find()),
        fenix: true);
    Get.lazyPut<StaticContentRepository>(
        () => StaticContentRepositoryImpl(Get.find()),
        fenix: true);

    /* Dio */

    Get.lazyPut(() => Dio(), fenix: true);

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
    Get.lazyPut<YoutubeRepository>(() => YoutubeRepositoryImpl(Get.find()),
        fenix: true);
  }
}
