// import 'package:uppercut_fantube/data/repository/staticContent/static_content_repository.dart';
// import 'package:uppercut_fantube/domain/base/base_no_param_use_case.dart';
// import 'package:uppercut_fantube/domain/model/content/home/banner.dart';
//
// /** Created By Ximya - 2022.02.09
//  *  홈 스크린 상단에 위치한 배너 컨텐츠 정보를 불러오는 메소드
//  *  Local Storage에 배너 컨텐츠 정보가 저장되어 있을 경우 api call을 따로 하지 않고 우회함.
//  *  상세 로직은 아래와 같은.
//  *
//  *  1) Local Storage에 json데이터가 저장되어 있는지 확인
//  *    1-1) 저장되어 있다면 'key' 값이 최신화 되어 있는지 확인
//  *
//  *  2) 저장되어 있는 데이터가 없거나 'key'값이 최신화 되어 있지 않다면 api를 호출함
//  *
//  *  3) 호출을 완료한 후 local storage에 호출한 데이터 저장.
//  * */
//
// class LoadBannerContentUseCase extends BaseNoParamUseCase<BannerModel> {
//   LoadBannerContentUseCase(this._repository);
//
//   final StaticContentRepository _repository;
//
//   @override
//   Future<BannerModel> call() async{
//
//
//   }
// }
