import 'package:soon_sak/utilities/index.dart';

class ProfileSettingViewModel extends BaseViewModel {
  ProfileSettingViewModel(this._userService);

  /* Data Modules */
  final UserService _userService;


  /* Controllers */
  late TextEditingController textEditingController;


  UserModel get userInfo => _userService.userInfo!;

  @override
  void onInit() {
    super.onInit();
    textEditingController = TextEditingController();
    textEditingController.text = userInfo.displayName!;
  }
}
