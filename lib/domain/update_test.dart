import 'package:dio/dio.dart';
import 'package:soon_sak/app/environment/environment.dart';
import 'dart:convert';

import 'package:soon_sak/data/dataSource/tmdb/tmdb_data_source.dart';
import 'package:soon_sak/domain/enum/media_type_enum.dart';
import 'package:soon_sak/domain/model/content/splitted_id_and_type.dart';

import '../app/di/locator/locator.dart';

class UpdateTest {
  final TmdbDataSource _tmdb = locator<TmdbDataSource>();

  void updateTitles() async {
    try {
      // HTTP 통신을 위한 Dio 인스턴스 생성
      Dio dio = Dio();

      // Firebase Realtime Database의 URL 설정
      String databaseUrl =
          'https://${Environment.baseUrl}-default-rtdb.asia-southeast1.firebasedatabase.app';

      // 업데이트할 데이터를 가져올 Firebase Realtime Database의 경로 설정
      String firebasePath = '/categoryContent/page2/items';

      // Firebase Realtime Database에서 아이템 데이터 가져오기
      String itemsUrl = '$databaseUrl$firebasePath.json';
      Response itemsResponse = await dio.get(itemsUrl);
      List<dynamic> itemData = itemsResponse.data;
      int itemCount = itemData.length;

      for (int i = 0; i < itemCount; i++) {
        List<dynamic> nestedItemData = itemData[i]['contents'];
        for (int j = 0; j < nestedItemData.length; j++) {
          // 각 아이템의 ID
          String itemId = nestedItemData[j]['id'];

          // TMDB API를 사용하여 아이템의 제목 가져오기
          if (SplittedIdAndType.fromOriginId(itemId).type ==
              MediaType.movie) {
            final tmdbRes = await _tmdb.loadMovieInfo(
                SplittedIdAndType.fromOriginId(itemId).id);
            String itemTitle = tmdbRes.title;
            // 데이터를 업데이트할 Firebase Realtime Database의 URL 설정
            String url = '$databaseUrl$firebasePath/$i/contents/$j.json';

            // 업데이트할 데이터 생성
            // 업데이트할 데이터 생성
            Map<String, dynamic> updateData = {
              'id': itemId,
              'posterImgUrl': nestedItemData[j]['posterImgUrl'],
              'title': itemTitle,
            };

            // HTTP PUT 요청 전송
            Response response = await dio.put(url, data: updateData);

            // 요청이 성공적으로 처리되었는지 확인
            if (response.statusCode == 200) {
              print('제목이 업데이트되었습니다: $i');
            } else {
              print('업데이트 실패: $i');
            }
          } else {
            final tmdbRes = await _tmdb.loadTvContentInfo(
                SplittedIdAndType.fromOriginId(itemId).id);
            String itemTitle = tmdbRes.name;
            // 데이터를 업데이트할 Firebase Realtime Database의 URL 설정
            String url = '$databaseUrl$firebasePath/$i/contents/$j.json';

            // 업데이트할 데이터 생성
            Map<String, dynamic> updateData = {
              'id': itemId,
              'posterImgUrl': nestedItemData[j]['posterImgUrl'],
              'title': itemTitle,
            };

            // HTTP PUT 요청 전송
            Response response = await dio.put(url, data: updateData);

            // 요청이 성공적으로 처리되었는지 확인
            if (response.statusCode == 200) {
              print('제목이 업데이트되었습니다: $i');
            } else {
              print('업데이트 실패: $i');
            }
          }
        }
      }
    } catch (error) {
      print('에러 발생: $error');
    }
  }
}
