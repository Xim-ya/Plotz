import 'package:rxdart/rxdart.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/presentation/index.dart';
import 'package:soon_sak/utilities/index.dart';

class SearchValidateUrlImpl
    with SearchHandlerMixin
    implements SearchValidateUrlUseCase {

  final BehaviorSubject<ValidationState> videoUrlValidState = BehaviorSubject<ValidationState>.seeded(ValidationState.initState);
  @override
  String? selectedChannelId;
  @override
  String? selectedVideoId;
  Timer? _debounce;

  @override
  String get searchedKeyword => fieldController.value.text;

  @override
  BehaviorSubject<ValidationState>  get isVideoValid => videoUrlValidState;


  // 비디오 url 유효성 검사
  Future<void> checkVideoIdValidation(String? videoId) async {
    try {
      final response = await YoutubeMetaData.yt.videos.get(videoId);
      videoUrlValidState.add(ValidationState.valid);
      selectedChannelId = response.channelId.value;
      selectedVideoId = videoId;
    } catch (e) {
      videoUrlValidState.add(ValidationState.invalid);

    }
  }

  // 붙여넣기 버튼이 클릭 되었을 시
  @override
  Future<void> onPasteBtnTapped(BuildContext context) async {
    fieldNode.unfocus(); // 키보드 가리기

    videoUrlValidState.add(ValidationState.isLoading);
    ClipboardData? pasteUrl = await Clipboard.getData('text/plain');

    if (pasteUrl?.text == null) {
      unawaited(AlertWidget.newToast(message: '복사된 링크가 없습니다', context));
      if (searchedKeyword != '') {
        videoUrlValidState.add(ValidationState.invalid);
        exposeRoundCloseBtn = true;
      } else {
        videoUrlValidState.add(ValidationState.initState);
      }
    } else {
      fieldController.text = pasteUrl?.text ?? '';
      final videoId = Formatter.getVideoIdFromYoutubeUrl(fieldController.text);
      await checkVideoIdValidation(videoId);
      exposeRoundCloseBtn = true;
    }
  }

  // 링크 입력 검색창에 키워드가 입력되었을 시
  @override
  Future<void> onSearchTermEntered() async {
    videoUrlValidState.add(ValidationState.isLoading);
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 300),
      () async {
        if (searchedKeyword == '') {
          videoUrlValidState.add(ValidationState.initState);
          return;
        }
        exposeRoundCloseBtn = true;
        final videoId = Formatter.getVideoIdFromYoutubeUrl(searchedKeyword);

        if (videoId == null) {
          videoUrlValidState.add(ValidationState.invalid);
        } else {
          await checkVideoIdValidation(videoId);
        }
      },
    );
  }

  // 검색창 'x' 버튼이 클릭 되었을 때
  @override
  void onCloseBtnTapped() {
    fieldController.text = '';
    exposeRoundCloseBtn = false;
    videoUrlValidState.value = ValidationState.initState;
  }

  @override
  TextEditingController get textEditingController => fieldController;

  @override
  FocusNode get focusNode => fieldNode;

  @override
  bool get showRoundCloseBtn => exposeRoundCloseBtn;
}
