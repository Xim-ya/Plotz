import 'dart:async';

import 'package:flutter/services.dart';
import 'package:uppercut_fantube/domain/enum/validation_state_enum.dart';
import 'package:uppercut_fantube/utilities/index.dart';

/** Created By Ximya - 2023.02.01
 *  입력된 유튜브 링크의 입력 및 유효성 검사 로직의 기능을 수행하는 UseCase
 *  [RegisterScreen] > [RegisterVideoLinkPageView] 에서 사용됨
 * */

class ValidateVideoUrlUseCase {
  final FocusNode focusNode = FocusNode();
  final TextEditingController textEditingController = TextEditingController();
  final Rx<ValidationState> videoUrlValidState = ValidationState.initState.obs;
  String? selectedChannelId;
  String? selectedVideoId;
  Timer? _debounce;

  String get searchedKeyword => textEditingController.value.text;

  ValidationState get isVideoValid => videoUrlValidState.value;
  RxBool showRoundCloseBtn = false.obs;

  // 비디오 url 유효성 검사
  Future<void> checkVideoIdValidation(String? videoId) async {
    try {
      final response = await YoutubeMetaData.yt.videos.get(videoId);
      videoUrlValidState(ValidationState.valid);
      selectedChannelId = response.channelId.value;
      selectedVideoId = videoId;
    } catch (e) {
      videoUrlValidState(ValidationState.invalid);
    }
  }

  // 붙여넣기 버튼이 클릭 되었을 시
  Future<void> onPasteBtnTapped() async {
    focusNode.unfocus(); // 키보드 가리기

    videoUrlValidState(ValidationState.isLoading);
    ClipboardData? pasteUrl = await Clipboard.getData('text/plain');

    if (pasteUrl?.text == null) {
      unawaited(AlertWidget.toast('복사된 링크가 없습니다'));
      if (searchedKeyword != '') {
        videoUrlValidState(ValidationState.invalid);
        showRoundCloseBtn(true);
      } else {
        videoUrlValidState(ValidationState.initState);
      }
    } else {
      textEditingController.text = pasteUrl?.text ?? '';
      final videoId =
          Formatter.getVideoIdFromYoutubeUrl(textEditingController.text);
      await checkVideoIdValidation(videoId);
      showRoundCloseBtn(true);
    }
  }

  // 링크 입력 검색창에 키워드가 입력되었을 시
  Future<void> onVideoUrlFieldChanged(String input) async {
    videoUrlValidState(ValidationState.isLoading);

    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 300),
      () async {
        if (input == '') {
          videoUrlValidState(ValidationState.initState);
          return;
        }
        showRoundCloseBtn(true);
        final videoId = Formatter.getVideoIdFromYoutubeUrl(input);

        if (videoId == null) {
          videoUrlValidState(ValidationState.invalid);
        } else {
          await checkVideoIdValidation(videoId);
        }
      },
    );
  }

  // 검색창 'x' 버튼이 클릭 되었을 때
  void onCloseBtnTapped() {
    textEditingController.text = '';
    showRoundCloseBtn(false);
    videoUrlValidState.value = ValidationState.initState;
  }
}

class _YoutubeVideoInfo {
  final String videoId;
  final String channelName;
  final String channelImg;

  _YoutubeVideoInfo(
      {required this.videoId,
      required this.channelName,
      required this.channelImg});
}
