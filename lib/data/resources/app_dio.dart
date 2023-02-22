import 'dart:convert';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';


/** Created By Ximya - 2023.02.21
 *  네트워크 패키지 [Dio] 관련 설정
 *  compute 메소드를 적용하여 별도의 스레드에서 통신을 할 수 있도록 함.
 *  로그 인터셉터 로직 적용
 * */

abstract class AppDio {
  AppDio._internal();

  static Dio? _instance;

  static Dio getInstance() => _instance ??= _AppDio();
}

class _AppDio with DioMixin implements Dio {
  _AppDio() {
    httpClientAdapter = DefaultHttpClientAdapter();
    options = BaseOptions(
      connectTimeout: 30000,
      receiveTimeout: 30000,
      sendTimeout: 30000,
      receiveDataWhenStatusError: true,
      headers: <String, dynamic>{
        'accept': 'application/json',
      },
    );
    (transformer as DefaultTransformer).jsonDecodeCallback = parseJson;


    final Dio tokenDio = Dio();

    tokenDio.options = options;

    // 로그 인터셉터 로직 추가
    tokenDio.interceptors.addAll([
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    ]);

    interceptors.addAll([
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      )
    ]);
  }
}

/** compute 메소드 적용 최상단 메소드에서 실행*/

_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  print('------ COMPUTE METHOD ACTIVATED ${text}');
  return compute(_parseAndDecode, text);
}

