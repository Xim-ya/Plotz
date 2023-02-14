import 'package:soon_sak/domain/service/user_service.dart';
import 'package:soon_sak/utilities/index.dart';

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
