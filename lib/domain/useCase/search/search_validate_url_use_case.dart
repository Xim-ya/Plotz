import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2023.02.01
 *  입력된 유튜브 링크의 입력 및 유효성 검사 로직의 기능을 수행하는 UseCase
 *  [RegisterScreen] > [RegisterVideoLinkPageView] 에서 사용됨
 * */

abstract class SearchValidateUrlUseCase {
  FocusNode get focusNode;

  TextEditingController get textEditingController;

  Rx<ValidationState> get videoUrlValidState;

  String? get selectedChannelId;

  String? get selectedVideoId;

  String get searchedKeyword;

  ValidationState get isVideoValid;

  bool get showRoundCloseBtn;

  // 붙여넣기 버튼이 클릭 되었을 시
  Future<void> onPasteBtnTapped();

  // 링크 입력 검색창에 키워드가 입력되었을 시
  Future<void> onSearchTermEntered();

  // 검색창 'x' 버튼이 클릭 되었을 때
  void onCloseBtnTapped();
}

