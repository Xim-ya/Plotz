import 'package:soon_sak/domain/model/content/onboarding/preference_content.dart';
import 'dart:math';
import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2023.06.19
 *  온보딩 콘텐츠 정보 섹션에서 사용되는 UseCase [UserContentPreferencesViewModel]
 *  앱 내부에 저장되어 있는 콘텐츠 객체를 불러오고 paged 호출 방식으로 데이터를 호출 함
 * */

class LoadPagedPreferenceContentListUseCase {
  /* Variables */
  int pageSize = 10;
  final List<PreferenceContent> _items = PreferenceContent.getList;

  /* Controllers */
  late final PagingController<int, PreferenceContent> pagingController =
      PagingController<int, PreferenceContent>(firstPageKey: 0);

  /* Intents */
  // 데이터 추가 메소드
  Future<void> _fetchPage() async {
    if (_items.length > pageSize) {
      final randomItem = getRandomItems(_items, pageSize);
      pagingController.appendPage(randomItem, 0);
    } else {
      _items.shuffle();
      pagingController.appendLastPage(_items);
    }
  }

  /// 무작위로 콘텐츠 아이템 추출 메소드
  /// 호출된 데이터는 전역변수로 관리되고 있는 [_items] 배열에서 제거됨
  List<PreferenceContent> getRandomItems(
      List<PreferenceContent> someArray, int count) {
    var arrayCopy = List<PreferenceContent>.from(someArray);
    count = min(count, arrayCopy.length);
    var selectedElements = <PreferenceContent>[];

    var random = Random();
    for (var i = 0; i < count; i++) {
      var randomIndex = random.nextInt(arrayCopy.length);
      selectedElements.add(arrayCopy[randomIndex]);
      _items.remove(arrayCopy[randomIndex]);
      arrayCopy.removeAt(randomIndex);
    }

    return selectedElements;
  }

  // UseCase 초기화 구문
  // Controller 초기화 구문
  void initUseCase() {
    pagingController.addPageRequestListener((_) {
      _fetchPage();
    });
  }
}
