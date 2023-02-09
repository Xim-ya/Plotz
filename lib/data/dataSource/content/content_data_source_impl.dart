import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uppercut_fantube/domain/model/staticContent/banner.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class ContentDataSourceImpl
    with ApiErrorHandlerMixin
    implements ContentDataSource {
  // 홈 상단 노출 컨텐츠 리스트
  @override
  Future<List<BannerItem>> loadBannerContentList() async {
    final url = Uri.parse(
        'https://soonsak-15350-default-rtdb.asia-southeast1.firebasedatabase.app/banner.json');


    try {
      final response = await http.get(url);
      var pdfText= await json.decode(response.body);
      print("=========== 테스트 \n ${pdfText}");

      } catch (e) {
      print('코드 오류');
      print(e);
    }




    // 임시 Json Mock up Data
    // top_ten_content_list.json
    var jsonText = await rootBundle.loadString('assets/mocks/banner.json');
    Map<String, dynamic> data = json.decode(jsonText);
    List<dynamic> aim = data['items'];

    return aim.map((e) => BannerItem.fromJson(e)).toList();

    // final responseValue = ChannelImagesDescriptionsReswponse.fromJson(data);
    // return responseValue;
  }

  // 컨텐츠 에피소드 리스트 정보
  @override
  Future<List<ContentEpisodeInfoItem>> loadContentEpisodeItemList() async {
    // 임시 Json Mock up Data
    var jsonText = await rootBundle
        .loadString('assets/mocks/content_season_info_list.json');
    Map<String, dynamic> data = json.decode(jsonText);
    List<dynamic> aim = data['episode'];
    return aim.map((e) => ContentEpisodeInfoItem.fromJson(e)).toList();
  }

  // Top10 컨텐츠 리스트 호출
  @override
  Future<List<ContentShell>> loadTopTenContentList() async {
    // 임시 Json Mock up Data
    // top_ten_content_list.json
    var jsonText =
        await rootBundle.loadString('assets/mocks/top_ten_content_list.json');
    Map<String, dynamic> data = json.decode(jsonText);
    List<dynamic> aim = data['items'];
    return aim.map((e) => ContentShell.fromJson(e)).toList();
  }

  // 카테고리 컨텐츠 리스트
  @override
  Future<List<CategoryBaseContentList>> loadContentWithCategory() async {
    // 임시 Json Mock up Data
    // top_ten_content_list.json
    var jsonText = await rootBundle
        .loadString('assets/mocks/category_base_content_list.json');
    Map<String, dynamic> data = json.decode(jsonText);
    List<dynamic> aim = await data['items'];
    return aim.map((e) => CategoryBaseContentList.fromJson(e)).toList();
  }

  // 모든 드라마 컨텐츠 리스트
  @override
  Future<List<SimpleContentInfo>> loadAllOfTvContentList() async {
    // 임시 Json Mock up Data
    // top_ten_content_list.json
    var jsonText =
        await rootBundle.loadString('assets/mocks/total_tv_list.json');
    Map<String, dynamic> data = json.decode(jsonText);
    List<int> aim = await List<int>.from(data['items']);
    return aim.map((e) => SimpleContentInfo.fromJson(e)).toList();
  }

  // 모든 영화 컨텐츠 리스트
  @override
  Future<List<SimpleContentInfo>> loadAllOfMovieContentList() async {
    // 임시 Json Mock up Data
    // top_ten_content_list.json
    var jsonText =
        await rootBundle.loadString('assets/mocks/total_movie_list.json');
    Map<String, dynamic> data = json.decode(jsonText);
    List<int> aim = await List<int>.from(data['items']);
    return aim.map((e) => SimpleContentInfo.fromJson(e)).toList();
  }

  // 특정 드라라 컨텐츠 비디오 정보
  @override
  Future<ContentVideos> loadDramaContentVideoList(int contentId) async {
    var jsonText =
        await rootBundle.loadString('assets/mocks/tv_content_video_list.json');
    Map<String, dynamic> data = json.decode(jsonText);

    List<Map<String, dynamic>> aim =
        List<Map<String, dynamic>>.from(data['items']);

    final arang = aim
        .singleWhere((element) => element.keys.first == contentId.toString());

    final formattedRes = List<Map<String, dynamic>>.from(arang.values.single);

    return ContentVideos.fromDramaJson(formattedRes);
  }

  // 특정 영화 컨텐츠 비디어 정보 정보
  @override
  Future<ContentVideos> loadMovieContentVideoList(int contentId) async {
    var jsonText = await rootBundle
        .loadString('assets/mocks/movie_content_video_list.json');
    Map<String, dynamic> data = json.decode(jsonText);

    List<Map<String, dynamic>> aim =
        List<Map<String, dynamic>>.from(data['items']);

    final arang = aim
        .singleWhere((element) => element.keys.first == contentId.toString());

    final formattedRes = List<Map<String, dynamic>>.from(arang.values.single);

    print(formattedRes);

    return ContentVideos.fromMovieJson(formattedRes);
  }

  // 탐색 컨텐츠 Id (contentId, videoId) 리스트
  @override
  Future<List<ExploreContentIdInfo>> loadExploreContentIdInfoList() async {
    // 임시 Json Mock up Data
    // top_ten_content_list.json
    var jsonText = await rootBundle
        .loadString('assets/mocks/explore_content_Id_list.json');
    List<Map<String, dynamic>> formatData =
        List<Map<String, dynamic>>.from(json.decode(jsonText)['items']);
    return formatData.map((e) => ExploreContentIdInfo.fromJson(e)).toList();
  }
}
