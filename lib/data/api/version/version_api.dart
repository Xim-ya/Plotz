import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:retrofit/retrofit.dart';
import 'package:soon_sak/data/api/version/response/version_response.dart';

part 'version_api.g.dart';

final String firebaseKey = dotenv.env['FIREBASE_KEY']!;

@RestApi(
    baseUrl:
        'https://\$firebaseKey-default-rtdb.asia-southeast1.firebasedatabase.app')
abstract class VersionApi {
  factory VersionApi(Dio dio, {String baseUrl}) = _VersionApi;

  @GET('/version/{platform}.json')
  Future<VersionResponse> loadVersionInfo(@Path('platform') String platform);
}
