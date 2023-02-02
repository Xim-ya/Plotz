import 'package:uppercut_fantube/utilities/index.dart';

class SearchValidateUrlImpl
    with SearchHandlerMixin
    implements SearchValidateUrlUseCase {


  @override
  final Rx<ValidationState> videoUrlValidState = ValidationState.initState.obs;
  @override
  String? selectedChannelId;
  @override
  String? selectedVideoId;

  Timer? _debounce;

  @override
  String get searchedKeyword => textEditingController.value.text;

  @override
  ValidationState get isVideoValid => videoUrlValidState.value;

  @override
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
  @override
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
  @override
  Future<void> onSearchTermEntered() async {
    videoUrlValidState(ValidationState.isLoading);

    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 300),
          () async {
        if (searchedKeyword == '') {
          videoUrlValidState(ValidationState.initState);
          return;
        }
        showRoundCloseBtn(true);
        final videoId = Formatter.getVideoIdFromYoutubeUrl(searchedKeyword);

        if (videoId == null) {
          videoUrlValidState(ValidationState.invalid);
        } else {
          await checkVideoIdValidation(videoId);
        }
      },
    );
  }



  // 검색창 'x' 버튼이 클릭 되었을 때
  @override
  void onCloseBtnTapped() {
    textEditingController.text = '';
    showRoundCloseBtn(false);
    videoUrlValidState.value = ValidationState.initState;
  }


}
