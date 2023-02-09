import 'package:uppercut_fantube/data/dataSource/staticContent/static_content_data_source.dart';
import 'package:uppercut_fantube/data/dto/staticContent/response/banner_response.dart';
import 'package:uppercut_fantube/data/dto/staticContent/static_content_api.dart';

class StaticContentDataSourceImpl extends StaticContentDataSource {
  StaticContentDataSourceImpl(this._api);

  final StaticContentApi _api;

  // TODO:  여기서 호출할지 말지를 정해야힘 Local Sotrage 로직 기반
  @override
  Future<BannerResponse> loadBannerContentList() =>
      loadResponseOrThrow(() => _api.loadBannerContentList());
}
