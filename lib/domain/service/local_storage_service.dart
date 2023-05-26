import 'dart:developer';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:soon_sak/utilities/index.dart';

/* Created By Ximya - 2022.02.09
*  값이 일정 기간동안 고정되어 있는 데이터의 API Call을 최소화 하기 위해
*  Local Storage에 일부 데이터를 저장하고 받아오는 로직을 택함.
*
*  해당 서비스 모듈은 LocalStorage 관련
*  읽기, 쓰기, 삭제 로직을 담당
*
*  현재 앱에서 사용하고 있는 LocalStorage의 db명 및 필드 값은 아래와 같음
*
*  version 1
*  - db: content.db
*    1) field : banner <-- 홈 스크린 배너 데이터
*    2) field : topTen <-- 홈 스크린 TopTen 컨텐츠 리스트 데이터
*    3) field : categoryCollection1 <-- 홈 스크린 카테고리 컨텐츠 데이터
*    3) field : categoryCollection2
*
*
* ** NEW ONE **
*    4) field: topPositionedCollection
*
* */

class LocalStorageService  {
  late Directory dir;
  late StoreRef store;
  late String dbPath;




  // 로컬 스토리지 초기화 작업
  Future<void> initStorage() async {
    store = StoreRef.main();
    dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true);
    dbPath = join('${dir.path}/storeData', 'content.db');
  }

  // 데이터 조회
  Future<Object?> getData({required String fieldName}) async {
    try {
      var db = await databaseFactoryIo.openDatabase(dbPath, version: 1);
      var data = await store.record(fieldName).get(db);
      log('====== 로컬 데이터 읽기 성공 / RESULT : $data');
      return data;
    } catch (e) {
      log('====== 로컬 데이터 읽기 실패 / $e');
      return null;
    }
  }

  // 데이터 저장
  Future<void> saveData(
      {required String fieldName, required Object data,}) async {
    try {
      var db = await databaseFactoryIo.openDatabase(dbPath, version: 1);
      await store.record(fieldName).put(db, data);
      log('====== 로컬 데이터 저장 성공 $fieldName');
    } catch (e) {
      log('====== 로컬 데이터 저장 실패 / $e');
    }
  }

  // 데이터 삭제
  Future<void> deleteData(
      {required String fieldName,}) async {
    try {
      var db = await databaseFactoryIo.openDatabase(dbPath, version: 1);
      await store.record(fieldName).delete(db);
      log('====== 로컬 데이터 삭제 성공');
    } catch (e) {
      log('====== 로컬 데이터 삭제 실패 / $e');
    }
  }

  Future<void> prepare() async {
    await initStorage();
  }
}