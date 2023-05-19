import 'package:dio/dio.dart';
import 'package:soon_sak/data/api/channel/channel_api.dart';
import 'package:soon_sak/data/api/channel/channel_api_impl.dart';
import 'package:soon_sak/data/api/content/content_api_impl.dart';
import 'package:soon_sak/data/api/version/version_api.dart';
import 'package:soon_sak/data/dataSource/channel/channel_data_source.dart';
import 'package:soon_sak/data/dataSource/channel/channel_data_source_impl.dart';
import 'package:soon_sak/data/dataSource/version/version_data_sourcel_impl.dart';
import 'package:soon_sak/data/firebase/app_fire_storage.dart';
import 'package:soon_sak/data/repository/channel/channel_respoitory.dart';
import 'package:soon_sak/data/repository/channel/channel_respository_impl.dart';
import 'package:soon_sak/data/repository/version/version_repository_impl.dart';
import 'package:soon_sak/data/resources/app_dio.dart';
import 'package:soon_sak/utilities/index.dart';

abstract class NewDataModules {
  NewDataModules._();

  static void dependencies() {
    /* Auth */
    GetIt.instance.registerLazySingleton<AuthApi>(() => AuthApiImpl());

    GetIt.instance.registerLazySingleton<AuthDataSource>(
        () => AuthDataSourceImpl(api: GetIt.I<AuthApi>()));

    GetIt.instance.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(dataSource: GetIt.I<AuthDataSource>()));

    /* User*/
    GetIt.instance.registerLazySingleton<UserApi>(() => UserApiImpl());

    GetIt.instance.registerLazySingleton<UserDataSource>(
        () => UserDataSourceImpl(api: GetIt.I<UserApi>()));

    GetIt.instance.registerLazySingleton<UserRepository>(
        () => UserRepositoryImpl(dataSource: GetIt.I<UserDataSource>()));

    /* Version */
    GetIt.instance
        .registerLazySingleton(() => VersionApi(AppDio.getInstance()));
    GetIt.instance.registerLazySingleton<VersionDataSource>(
        () => VersionDataSourceImpl(GetIt.I<VersionApi>()));
    GetIt.instance.registerLazySingleton<VersionRepository>(
        () => VersionRepositoryImpl(GetIt.I<VersionDataSource>()));

    /* Static Content */
    GetIt.instance.registerLazySingleton<StaticContentApi>(
        () => StaticContentApiImpl(AppDio.getInstance()));
    GetIt.instance.registerLazySingleton<StaticContentDataSource>(() =>
        StaticContentDataSourceImpl(
            api: GetIt.I<StaticContentApi>(),
            localStorage: GetIt.I<LocalStorageService>()));
    GetIt.instance.registerLazySingleton<StaticContentRepository>(
        () => StaticContentRepositoryImpl(GetIt.I<StaticContentDataSource>()));

    /* Youtube */
    GetIt.I.registerLazySingleton<YoutubeApi>(() => YoutubeApiImpl());
    GetIt.I.registerLazySingleton<YoutubeDataSource>(
        () => YoutubeDataSourceImpl(GetIt.I<YoutubeApi>()));
    GetIt.I.registerLazySingleton<YoutubeRepository>(
        () => YoutubeRepositoryImpl(GetIt.I<YoutubeDataSource>()));

    /* Channel */
    GetIt.I.registerLazySingleton<ChannelApi>(() => ChannelApiImpl());
    GetIt.I.registerLazySingleton<ChannelDataSource>(
        () => ChannelDataSourceImpl(GetIt.I<ChannelApi>()));
    GetIt.I.registerLazySingleton<ChannelRepository>(
        () => ChannelRepositoryImpl(GetIt.I<ChannelDataSource>()));

    /* Dio */
    GetIt.I.registerLazySingleton(() => Dio());

    /* Firebase */
    GetIt.I.registerSingleton(() => AppFireStore.getInstance);
    GetIt.I.registerSingleton(() => AppFireStorage.getInstance);

    /* Content */
    GetIt.I.registerLazySingleton<ContentApi>(() => ContentApiImpl());
    GetIt.I.registerLazySingleton<ContentDataSource>(
        () => ContentDataSourceImpl(GetIt.I<ContentApi>()));
    GetIt.I.registerLazySingleton<ContentRepository>(
        () => ContentRepositoryImpl(GetIt.I<ContentDataSource>()));

    /* Tmdb */
    GetIt.I.registerLazySingleton(() => TmdbApi(AppDio.getInstance()));
    GetIt.I.registerLazySingleton<TmdbDataSource>(
        () => TmdbDataSourceImpl(GetIt.I<TmdbApi>()));
    GetIt.I.registerLazySingleton<TmdbRepository>(
        () => TmdbRepositoryImpl(GetIt.I<TmdbDataSource>()));
  }
}
