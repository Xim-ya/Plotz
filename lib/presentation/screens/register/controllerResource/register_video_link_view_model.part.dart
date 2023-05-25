part of '../register_view_model.dart';

extension RegisterVideoLinkViewModel on RegisterViewModel {
  // TextForm Focus Node
  FocusNode get videoFormFocusNode => validateVideoUrlUseCase.focusNode;

  // TextForm Controller
  TextEditingController get videoFormController =>
      validateVideoUrlUseCase.textEditingController;


  // 입력된 video url 유효 여부
  BehaviorSubject<ValidationState> get videoUrlValidState =>
      validateVideoUrlUseCase.isVideoValid;

}
