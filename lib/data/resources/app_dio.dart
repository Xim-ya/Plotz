import 'dart:convert';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/** Created By Ximya - 2023.02.21
 *  네트워크 패키지 [Dio] 관련 설정
 *  compute 메소드를 적용하여 별도의 스레드에서 네트워크 통신을 할 수 있도록 함.
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

    interceptors.addAll([
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      )
    ]);
  }
}

// compute 메소드 적용
// 최상단 메소드에서 실행
// compute 함수 내부 에러 핸들링 추가
_parseAndDecode(String response) {
  try {
    return jsonDecode(response);
  } catch (e) {
    throw Exception('Failed to parse JSON');
  }
}

// compute 함수가 메모리 누수를 발생시키지 않도록 수정
Future<dynamic> parseJson(String text) async {
  return compute(_parseAndDecode, text);
}
