import 'package:dio/dio.dart';
import 'package:soon_sak/data/api/channel/channel_api.dart';
import 'package:soon_sak/data/api/channel/channel_api_impl.dart';
import 'package:soon_sak/data/api/content/content_api_impl.dart';
import 'package:soon_sak/data/api/version/version_api.dart';
import 'package:soon_sak/data/dataSource/channel/channel_data_source.dart';
import 'package:soon_sak/data/dataSource/channel/channel_data_source_impl.dart';
import 'package:soon_sak/data/dataSource/version/version_data_sourcel_impl.dart';
import 'package:soon_sak/data/firebase/app_fire_storage.dart';
import 'package:soon_sak/data/local/box/user/user_box.dart';
import 'package:soon_sak/data/local/dao/user/user_dao.dart';
import 'package:soon_sak/data/repository/channel/channel_respoitory.dart';
import 'package:soon_sak/data/repository/channel/channel_respository_impl.dart';
import 'package:soon_sak/data/repository/version/version_repository_impl.dart';
import 'package:soon_sak/data/resources/app_dio.dart';
import 'package:soon_sak/utilities/index.dart';

abstract class DataModules {
  DataModules._();

  static void dependencies() {
    /* Auth */
    locator.registerLazySingleton<AuthApi>(() => AuthApiImpl());

    locator.registerLazySingleton<AuthDataSource>(
        () => AuthDataSourceImpl(api: locator<AuthApi>()));

    locator.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(dataSource: locator<AuthDataSource>()));

    /* User*/
    locator.registerLazySingleton<UserApi>(() => UserApiImpl());

    locator.registerLazySingleton<UserDao>(()=> UserDao());

    locator.registerLazySingleton<UserDataSource>(
      () => UserDataSourceImpl(
        api: locator<UserApi>(),
        local: locator<UserDao>(),
      ),
    );

    locator.registerLazySingleton<UserRepository>(
        () => UserRepositoryImpl(dataSource: locator<UserDataSource>()));

    /* Version */
    locator.registerLazySingleton(() => VersionApi(AppDio.getInstance()));
    locator.registerLazySingleton<VersionDataSource>(
        () => VersionDataSourceImpl(locator<VersionApi>()));
    locator.registerLazySingleton<VersionRepository>(
        () => VersionRepositoryImpl(locator<VersionDataSource>()));

    /* Static Content */
    locator.registerLazySingleton<StaticContentApi>(
        () => StaticContentApiImpl(AppDio.getInstance()));
    locator.registerLazySingleton<StaticContentDataSource>(() =>
        StaticContentDataSourceImpl(
            api: locator<StaticContentApi>(),
            localStorage: locator<LocalStorageService>()));
    locator.registerLazySingleton<StaticContentRepository>(
        () => StaticContentRepositoryImpl(locator<StaticContentDataSource>()));

    /* Youtube */
    locator.registerLazySingleton<YoutubeApi>(() => YoutubeApiImpl());
    locator.registerLazySingleton<YoutubeDataSource>(
        () => YoutubeDataSourceImpl(locator<YoutubeApi>()));
    locator.registerLazySingleton<YoutubeRepository>(
        () => YoutubeRepositoryImpl(locator<YoutubeDataSource>()));

    /* Channel */
    locator.registerLazySingleton<ChannelApi>(() => ChannelApiImpl());
    locator.registerLazySingleton<ChannelDataSource>(
        () => ChannelDataSourceImpl(locator<ChannelApi>()));
    locator.registerLazySingleton<ChannelRepository>(
        () => ChannelRepositoryImpl(locator<ChannelDataSource>()));

    /* Dio */
    locator.registerLazySingleton(() => Dio());

    /* Firebase */
    locator.registerSingleton(() => AppFireStore.getInstance);
    locator.registerSingleton(() => AppFireStorage.getInstance);

    /* Content */
    locator.registerLazySingleton<ContentApi>(() => ContentApiImpl());
    locator.registerLazySingleton<ContentDataSource>(
        () => ContentDataSourceImpl(locator<ContentApi>()));
    locator.registerLazySingleton<ContentRepository>(
        () => ContentRepositoryImpl(locator<ContentDataSource>()));

    /* Tmdb */
    locator.registerLazySingleton(() => TmdbApi(AppDio.getInstance()));
    locator.registerLazySingleton<TmdbDataSource>(
        () => TmdbDataSourceImpl(locator<TmdbApi>()));
    locator.registerLazySingleton<TmdbRepository>(
        () => TmdbRepositoryImpl(locator<TmdbDataSource>()));
  }
}
