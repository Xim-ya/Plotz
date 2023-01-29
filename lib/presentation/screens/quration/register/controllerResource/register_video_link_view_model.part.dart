part of '../register_view_model.dart';

extension RegisterVideoLinkViewModel on RegisterViewModel {
  // 링크 입력 검색창에 키워드가 입력되었을 시
  Future<void> onVideoLinkFieldChanged(String input) async {
    isEnteredVideoUrlValid(ValidationState.isLoading);
    toggleSearchBarClosedBtn();

    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 300),
      () async {
        if (input == '') {
          isEnteredVideoUrlValid(ValidationState.initState);
          return;
        }
        final videoId = Formatter.getVideoIdFromYoutubeUrl(input);

        if (videoId == null) {
          isEnteredVideoUrlValid(ValidationState.invalid);
        } else {
          await checkVideoIdValidation(videoId);
        }
      },
    );
  }

  // 붙여넣기 버튼이 클릭 되었을 시
  Future<void> onPasteBtnTapped() async {
    focusNode.unfocus(); // 키보드 가리기
    isEnteredVideoUrlValid(ValidationState.isLoading);
    ClipboardData? pasteUrl = await Clipboard.getData('text/plain');

    if (pasteUrl?.text == null) {
      if (searchedKeyword != '') {
        isEnteredVideoUrlValid(ValidationState.invalid);
      } else {
        isEnteredVideoUrlValid(ValidationState.initState);
      }
    } else {
      textEditingController.text = pasteUrl?.text ?? '';
      final videoId =
          Formatter.getVideoIdFromYoutubeUrl(textEditingController.text);
      await checkVideoIdValidation(videoId);
    }
  }

  // 비디오 url 유효성 검사
  Future<void> checkVideoIdValidation(String? videoId) async {
    try {
      await YoutubeMetaData.yt.videos.get(videoId);
      isEnteredVideoUrlValid(ValidationState.valid);
    } catch (e) {
      isEnteredVideoUrlValid(ValidationState.invalid);
    }
  }

  // 하단 고정 버튼 노출 여부
  RxBool get show2StepFloatingBtn =>
      (isEnteredVideoUrlValid.value == ValidationState.valid).obs;
}
