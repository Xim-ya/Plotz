part of '../register_view_model.dart';

extension RegisterVideoLinkViewModel on RegisterViewModel {
  // TextForm Focus Node
  FocusNode get videoFormFocusNode => validateVideoUrlUseCase.focusNode;

  // TextForm Controller
  TextEditingController get videoFormController => validateVideoUrlUseCase.textEditingController;

  // TextForm 'X' 버튼 노출 여부
  RxBool get showVideoFormCloseBtn => validateVideoUrlUseCase.showRoundCloseBtn;

  // 입력된 video url 유효 여부
  ValidationState get videoUrlValidState => validateVideoUrlUseCase.isVideoValid;
}
