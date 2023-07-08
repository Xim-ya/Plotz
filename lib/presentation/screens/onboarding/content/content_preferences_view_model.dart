import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/presentation/index.dart';
import 'package:soon_sak/utilities/index.dart';

class ContentPreferenceViewModel extends BaseViewModel {
  ContentPreferenceViewModel(
      {required LoadPagedPreferenceContentListUseCase
          loadPagedPreferenceContentListUseCase})
      : _loadPagedPreferenceContentList = loadPagedPreferenceContentListUseCase;

  /* State Variables */
  bool hideGradient = true; // 앱바 배경색 노출 여부
  List<PreferredContent> selectedContent = []; // 선택된 콘텐츠 아이디 리스트
  int get countOfSelectedContent => selectedContent.length; // 선택된 콘텐츠 개수
  bool get isSufficient => selectedContent.length >= 3; // 선택 조건 만족 여부

  /* UseCases */
  final LoadPagedPreferenceContentListUseCase _loadPagedPreferenceContentList;

  /* Controller */
  PagingController<int, PreferredContent> get pagingController =>
      _loadPagedPreferenceContentList.pagingController;
  late final ScrollController scrollController;

  /* Intent */
  // 콘텐츠가 선택될 때
  void onContentTapped(PreferredContent content) {
    if (selectedContent.contains(content)) {
      selectedContent.remove(content);
    } else {
      selectedContent.add(content);
    }
    notifyListeners();
  }

  // 하단 '다음' 버튼이 클릭 되었을 떄
  void onNextBtnTapped() {
    if (isSufficient) {
      context.push(AppRoutes.onboarding2, extra: {'arg1': selectedContent});
    } else {
      showDialog(
        context: context,
        builder: (_) {
          return AppDialog.singleBtn(
            title: '알림',
            description: '3개 이상의 콘텐츠를 선택해 주세요',
            onBtnClicked: context.pop,
          );
        },
      );
    }
  }

  // 하단 상단 Gradient Box Visibility 여부를 조절하는 메소드.
  void setGradientBoxVisibility() {
    if (scrollController.offset >= 11 &&
        hideGradient == true &&
        scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
      hideGradient = false;
      notifyListeners();
      return;
    } else if (scrollController.offset >= 20) {
      return;
    } else {
      if (hideGradient == false &&
          scrollController.position.userScrollDirection ==
              ScrollDirection.forward) {
        hideGradient = true;
        notifyListeners();
      }
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    scrollController = ScrollController();
    scrollController.addListener(setGradientBoxVisibility);
    await _loadPagedPreferenceContentList.initUseCase();
  }
}
