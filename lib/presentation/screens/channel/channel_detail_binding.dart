import 'package:soon_sak/data/repository/channel/channel_repository.dart';
import 'package:soon_sak/domain/useCase/channel/load_paged_channel_contents_use_case.dart';
import 'package:soon_sak/presentation/screens/channel/channel_detail_view_model.dart';
import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/presentation/index.dart';

class ChannelDetailBinding extends Bindings {
  @override
  void dependencies() {
    super.dependencies();
    locator.registerFactory(
      () => ChannelDetailViewModel(
        channelArg: arg1,
        loadChannelContentsUseCase: locator<LoadPagedChannelContentsUseCase>(),
      ),
    );

    locator.registerFactory(
      () => LoadPagedChannelContentsUseCase(
        locator<ChannelRepository>(),
      ),
    );
  }

  @override
  void unRegisterDependencies() {
    super.unRegisterDependencies();
    safeUnregister<ChannelDetailViewModel>();
    safeUnregister<LoadPagedChannelContentsUseCase>();
  }
}
