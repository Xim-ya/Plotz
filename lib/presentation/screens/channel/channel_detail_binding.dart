import 'package:get/get.dart';
import 'package:soon_sak/domain/useCase/channel/load_paged_channel_contents_use_case.dart';
import 'package:soon_sak/presentation/screens/channel/channel_detail_view_model.dart';

class ChannelDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoadPagedChannelContentsUseCase(Get.find()));
  }

}
