import 'dart:convert';
import 'package:soon_sak/domain/enum/movie_genre_enum.dart';
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
  late final List<PreferredContent> _items;

  /* Controllers */
  late final PagingController<int, PreferredContent> pagingController =
      PagingController<int, PreferredContent>(firstPageKey: 0);

  /* Controllers */
  Timer? _debounce;

  /* Intents */
  // 데이터 추가 메소드
  void _fetchPage() {
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
  List<PreferredContent> getRandomItems(
      List<PreferredContent> someArray, int count) {
    var arrayCopy = List<PreferredContent>.from(someArray);
    count = min(count, arrayCopy.length);
    var selectedElements = <PreferredContent>[];

    var random = Random();
    for (var i = 0; i < count; i++) {
      var randomIndex = random.nextInt(arrayCopy.length);
      selectedElements.add(arrayCopy[randomIndex]);
      _items.remove(arrayCopy[randomIndex]);
      arrayCopy.removeAt(randomIndex);
    }

    return selectedElements;
  }

  // JSON 데이터를 파싱하여 _items 리스트에 할당
  Future<void> getJsonContents() async {
    final jsonStr =
        await rootBundle.loadString('assets/mocks/onboarding_contents.json');
    final parsed = json.decode(jsonStr).cast<Map<String, dynamic>>();
    _items = parsed
        .map<PreferredContent>((json) => PreferredContent(
              posterImgUrl: json['posterImgUrl'],
              contentId: json['contentId'],
              genres: List<ContentGenre>.from(json['genres']
                  .map((e) => ContentGenre.getContentFromJson(e as String))),
            ))
        .toList();
  }

  // UseCase 초기화 구문
  // Controller 초기화 구문
  Future<void> initUseCase() async {
    unawaited(getJsonContents());

    pagingController.addPageRequestListener((pageKey) {
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(Duration.zero, _fetchPage);
    });
  }
}
