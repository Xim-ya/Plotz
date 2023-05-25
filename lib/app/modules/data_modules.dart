// import 'package:dio/dio.dart';
// import 'package:soon_sak/data/api/channel/channel_api.dart';
// import 'package:soon_sak/data/api/channel/channel_api_impl.dart';
// import 'package:soon_sak/data/api/content/content_api_impl.dart';
// import 'package:soon_sak/data/api/version/version_api.dart';
// import 'package:soon_sak/data/dataSource/channel/channel_data_source.dart';
// import 'package:soon_sak/data/dataSource/channel/channel_data_source_impl.dart';
// import 'package:soon_sak/data/dataSource/version/version_data_sourcel_impl.dart';
// import 'package:soon_sak/data/firebase/app_fire_storage.dart';
// import 'package:soon_sak/data/repository/channel/channel_respoitory.dart';
// import 'package:soon_sak/data/repository/channel/channel_respository_impl.dart';
// import 'package:soon_sak/data/repository/version/version_repository_impl.dart';
// import 'package:soon_sak/data/resources/app_dio.dart';
// import 'package:soon_sak/utilities/index.dart';
//
// abstract class DataModules {
//   DataModules._();
//
//   static Future<void> getDependencies() async {
//     Get.put<Dio>(AppDio.getInstance(), permanent: true);
//
//     /* Version */
//     Get.lazyPut(() => VersionApi(Get.find()), fenix: true);
//     Get.lazyPut<VersionDataSource>(() => VersionDataSourceImpl(Get.find()),
//         fenix: true);
//     Get.lazyPut<VersionRepository>(() => VersionRepositoryImpl(Get.find()),
//         fenix: true);
//
//     /* Static Content */
//     Get.lazyPut<StaticContentApi>(() => StaticContentApiImpl(Get.find()),
//         fenix: true);
//     // Get.lazyPut<StaticContentDataSource>(
//     //     () => StaticContentDataSourceImpl(Get.find(), Get.find()),
//     //     fenix: true);
//     Get.lazyPut<StaticContentRepository>(
//         () => StaticContentRepositoryImpl(Get.find()),
//         fenix: true);
//
//     /* Youtube */
//     Get.lazyPut<YoutubeApi>(() => YoutubeApiImpl(), fenix: true);
//     Get.lazyPut<YoutubeRepository>(() => YoutubeRepositoryImpl(Get.find()),
//         fenix: true);
//     Get.lazyPut<YoutubeDataSource>(() => YoutubeDataSourceImpl(Get.find()),
//         fenix: true);
//
//     /* Channel */
//     Get.lazyPut<ChannelRepository>(() => ChannelRepositoryImpl(Get.find()),
//         fenix: true);
//     Get.lazyPut<ChannelDataSource>(() => ChannelDataSourceImpl(Get.find()),
//         fenix: true);
//     Get.lazyPut<ChannelApi>(() => ChannelApiImpl(), fenix: true);
//
//     /* Auth */
//     Get.lazyPut<AuthApi>(() => AuthApiImpl(), fenix: true);
//     // Get.lazyPut<AuthDataSource>(() => AuthDataSourceImpl(Get.find()),
//     //     fenix: true);
//     // Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find()),
//     //     fenix: true);
//
//     /* User */
//     Get.lazyPut<UserApi>(() => UserApiImpl(), fenix: true);
//     // Get.lazyPut<UserDataSource>(() => UserDataSourceImpl(Get.find()),
//     //     fenix: true);
//     // Get.lazyPut<UserRepository>(() => UserRepositoryImpl(Get.find()),
//     //     fenix: true);
//
//     /* Dio */
//
//     Get.lazyPut(() => Dio(), fenix: true);
//
//     /* FireBase */
//     Get.lazyPut(() => AppFireStore.getInstance, fenix: true);
//     Get.lazyPut(() => AppFireStorage.getInstance, fenix: true);
//
//     /* Content */
//     Get.lazyPut<ContentApi>(() => ContentApiImpl(), fenix: true);
//     Get.lazyPut<ContentDataSource>(() => ContentDataSourceImpl(Get.find()),
//         fenix: true);
//     Get.lazyPut<ContentRepository>(() => ContentRepositoryImpl(Get.find()),
//         fenix: true);
//
//     /* Tmdb */
//     Get.lazyPut(() => TmdbApi(Get.find()), fenix: true);
//     Get.lazyPut<TmdbRepository>(() => TmdbRepositoryImpl(Get.find()),
//         fenix: true);
//     Get.lazyPut(() => TmdbApi(Get.find()), fenix: true);
//     Get.lazyPut<TmdbDataSource>(() => TmdbDataSourceImpl(Get.find()),
//         fenix: true);
//
//   }
// }
