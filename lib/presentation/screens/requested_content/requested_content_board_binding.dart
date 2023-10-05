import 'package:soon_sak/app/di/binding.dart';
import 'package:soon_sak/app/di/locator/locator.dart';
import 'package:soon_sak/data/repository/user/user_repository.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/domain/model/content/myPage/requested_content.m.dart';
import 'package:soon_sak/domain/useCase/content/user/delete_requested_content_use_case.dart';
import 'package:soon_sak/domain/useCase/content/user/load_user_requested_contents_use_case.dart';
import 'package:soon_sak/presentation/screens/requested_content/requested_content_board_view_model.dart';

class RequestedContentBoardBinding extends Bindings {
  @override
  void dependencies() {
    super.dependencies();

    locator.registerFactory(
        () => DeleteRequestedContentUesCase(locator<UserRepository>()));
    locator.registerFactory(
      () => RequestedContentBoardViewModel(
          locator<DeleteRequestedContentUesCase>(),
          locator<LoadUserRequestedContentsUseCase>(),
          arg1 as List<RequestedContent>?,
          locator<UserService>()),
    );
  }

  @override
  void unRegisterDependencies() {
    super.unRegisterDependencies();
    locator.unregister<RequestedContentBoardViewModel>();
    locator.unregister<DeleteRequestedContentUesCase>();
  }
}
