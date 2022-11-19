import 'package:uppercut_fantube/domain/repository/content/content_repository.dart';
import 'package:uppercut_fantube/domain/repository/content/content_repository_impl.dart';
import 'package:uppercut_fantube/domain/useCase/load_content_main_info_use_case.dart';
import 'package:uppercut_fantube/utilities/index.dart';

abstract class DomainModules {
  DomainModules._();

  static void dependencies() {
    // 컨텐츠
    Get.lazyPut(() => LoadContentMainInfoUseCase(Get.find()), fenix: true);
    Get.lazyPut<ContentRepository>(() => ContentRepositoryImpl(), fenix: true);
  }
}
