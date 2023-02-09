import 'package:uppercut_fantube/data/dto/staticContent/response/content_key_response.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class StaticContentDataSourceImpl extends StaticContentDataSource {
  StaticContentDataSourceImpl(this._api);

  final StaticContentApi _api;

  // TODO:  여기서 호출할지 말지를 정해야힘 Local Sotrage 로직 기반
  @override
  Future<BannerResponse> loadBannerContents() async {
    // TODO: 임시 Mock Data
    return BannerResponse(
      '2022-11',
      [
        BannerItemResponse(
            id: 't-111800',
            videoId: 'TXMtLF5OANI',
            title: '올드맨',
            description:
                '하필이면 전직 특수 요원을 건드렸는데 개들이 싸움을 더 잘함 | 2022년 신작 중 가장 처절한 액션을 보여드립니다',
            imgUrl: 'https://i.ytimg.com/vi/TXMtLF5OANI/maxresdefault.jpg',
            backdropImgUrl: '/euYz4adiSHH0GE3YnTeh3uLfBvL.jpg'),
        BannerItemResponse(
          id: 't-1396',
          videoId: 'KfbFaQJK7Sc',
          title: '브레이킹 배드',
          description: '《브레이킹 베드》 | 진짜 존나 재밌음',
          imgUrl: 'https://i.ytimg.com/vi/KfbFaQJK7Sc/maxresdefault.jpg',
          backdropImgUrl: '/ggFHVNu6YYI5L9pCfOacjizRGt.jpg',
        )
      ],
    );

    return loadResponseOrThrow(() => _api.loadBannerContent());
  }

  @override
  Future<TopTenContentResponse> loadTopTenContents() async {
    return TopTenContentResponse(key: '2022-02-09-EFG', items: [
      TopTenContentItemResponse(
          id: 'm-210577', posterImgUrl: '/epEVLlIRErigv6YFkS6YQNFtCtj.jpg'),
      TopTenContentItemResponse(
          id: 'm-4965', posterImgUrl: '/9tG96b62438mIXi12dhBbIOBgiY.jpg'),
      TopTenContentItemResponse(
          id: 't-113988', posterImgUrl: '/f2PVrphK0u81ES256lw3oAZuF3x.jpg'),
      TopTenContentItemResponse(
          id: 't-1396', posterImgUrl: '/ggFHVNu6YYI5L9pCfOacjizRGt.jpg'),
    ]);

    return loadResponseOrThrow(() => _api.loadTopTenContent());
  }

  @override
  Future<ContentKeyResponse> loadStaticContentKeys() {
    return loadResponseOrThrow(() => _api.loadStaticContentKeys());
  }
}
