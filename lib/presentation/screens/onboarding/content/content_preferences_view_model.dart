import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:soon_sak/data/local/box/user/user_box.dart';
import 'package:soon_sak/data/local/dao/user/user_dao.dart';
import 'package:soon_sak/domain/model/content/onboarding/preference_content.dart';
import 'package:soon_sak/domain/useCase/onboarding/load_paged_preference_content_list.dart';
import 'package:soon_sak/utilities/index.dart';

class ContentPreferenceViewModel extends BaseViewModel {
  ContentPreferenceViewModel(
      {required LoadPagedPreferenceContentListUseCase
          loadPagedPreferenceContentListUseCase})
      : _loadPagedPreferenceContentList = loadPagedPreferenceContentListUseCase;

  /* State Variables */
  bool hideGradient = true; // 앱바 배경색 노출 여부
  List<String> selectedContentIds = []; // 선택된 콘텐츠 아이디 리스트
  int get countOfSelectedContent => selectedContentIds.length; // 선택된 콘텐츠 개수
  bool get isSufficient => selectedContentIds.length >= 3; // 선택 조건 만족 여부

  /* UseCases */
  final LoadPagedPreferenceContentListUseCase _loadPagedPreferenceContentList;

  /* Controller */
  PagingController<int, PreferenceContent> get pagingController =>
      _loadPagedPreferenceContentList.pagingController;
  late final ScrollController scrollController;

  /* Intent */
  // 콘텐츠가 선택될 때
  void onContentTapped(String contentId) {
    if (selectedContentIds.contains(contentId)) {
      selectedContentIds.remove(contentId);
    } else {
      selectedContentIds.add(contentId);
    }
    notifyListeners();
  }

  void onNextBtnTapped() {
    if (isSufficient) {
      context.push(AppRoutes.onboarding2);
    } else {}
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
  void onInit() async {
    super.onInit();
    _loadPagedPreferenceContentList.initUseCase();
    scrollController = ScrollController();
    scrollController.addListener(setGradientBoxVisibility);
  }
}
