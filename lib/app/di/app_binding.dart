import 'package:uppercut_fantube/domain/service/user_service.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class AppBinding extends Bindings {
  @override
  Future<void> dependencies() async{

    // 로컬 스토리지
    // await _preloadDependencies();




    DataModules.getDependencies();
    DomainModules.dependencies();
    PresentationModules.dependencies();
  }



  Future<void> _preloadDependencies() async{
    // Get.put(LocalStorageService());
    // Get.put(ContentService());
  }
}
