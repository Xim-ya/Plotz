import 'package:get/get.dart';
import 'package:uppercut_fantube/presentation/screens/contentDetail/content_detail_view_model.dart';

class ContentDetailBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ContentDetailViewModel(), fenix: true);
  }
}