import 'package:soon_sak/app/di/binding.dart';
import 'package:soon_sak/app/di/locator/locator.dart';
import 'package:soon_sak/domain/useCase/content/user/load_user_requested_contents_use_case.dart';
import 'package:soon_sak/presentation/screens/requested_content/requested_content_board_view_model.dart';

class RequestedContentBoardBinding extends Bindings {
  @override
  void dependencies() {
    super.dependencies();
    locator.registerFactory(() => RequestedContentBoardViewModel(
        locator<LoadUserRequestedContentsUseCase>()));
    /*locator.registerSingleton(
        LoadUserRequestedContentsUseCase(locator<UserRepository>()));*/
  }

  @override
  void unRegisterDependencies() {
    super.unRegisterDependencies();
    locator.unregister<RequestedContentBoardViewModel>();
    // locator.unregister<LoadUserRequestedContentsUseCase>();
  }
}
