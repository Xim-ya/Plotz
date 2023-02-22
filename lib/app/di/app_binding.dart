import 'package:dio/dio.dart';
import 'package:soon_sak/data/resources/app_dio.dart';
import 'package:soon_sak/utilities/index.dart';

class AppBinding extends Bindings {
  @override
  Future<void> dependencies() async{
    // Get.put(Dio());
    Get.put<Dio>(AppDio.getInstance(), permanent: true);
    DataModules.getDependencies();
    DomainModules.dependencies();
    PresentationModules.dependencies();
  }
}
