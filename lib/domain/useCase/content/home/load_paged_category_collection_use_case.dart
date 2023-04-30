import 'dart:convert';
import 'dart:developer';

import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2023.03.14
 *  홈 스크린에 보여지는 카테고리 컨텐츠 (Category Collection)는
 *  기본적으로 페이징 로직과
 *  Local Storage에 캐싱되어 있는 데이터를 가져오는 로직이 적용됨.
 *
 *  Local Storage 데이터의 존재 여부에 따라
 *  서버를 해서 데이터를 가져올지
 *  또는 Local Storage에서 데이터를 가져올지 분기됨.
 *
 *  위 로직은 데이터(DataSource) 레이어에서 분기하고
 *
 *  해당 UseCase에서는 LocalStorage 존배여부와
 *  LocalStorage에 저장되어 있는 키가 최신 키인지에 따라 `로컬 데이터`를 삭제하여
 *  `데이터 레이에어서 적절히 캐싱 로직을 실행할 수 있도록 함`.
 *
 *  간단하게 정리하자면 아래와 같음
 *  1) 캐싱 로직 - DataSource
 *  2) 페이징 로직 - UseCase
 *
 *
 *  *** NOTE ****
 *  [addPageRequestListener]가 순간 여러번 호출 되는 이슈가 존재
 *  라이브러리의 고질적인 문제로 판단됨
 *  이를 해결하기 위해 debounce delayed를 주어 중복 호출을 막음
 *  이슈 출처 : https://github.com/EdsonBueno/infinite_scroll_pagination/issues/172
 *
 * */

class LoadPagedCategoryCollectionUseCase {
  LoadPagedCategoryCollectionUseCase(
    this._staticContentRepository,
    this._localStorageService,
    this._contentService,
  );

  /* Data Modules */
  final StaticContentRepository _staticContentRepository;
  final LocalStorageService _localStorageService;
  final ContentService _contentService; // static content key 리스트 호출

  /* Variables */
  final Rxn<List<CategoryContentSection>> categoryContentCollection = Rxn();
  int currentPage = 1;
  bool isPagingAvailable = true;
  bool isInitialState = true;
  Timer? _debounce;

  /* Controller */
  PagingController<int, CategoryContentSection> pagingController =
      PagingController<int, CategoryContentSection>(firstPageKey: 1);

  /* Intents */
  // 'key' 값이 최신화 되어 있는지 확인
  bool _isRecentKey({required String jsonText, required String givenKey}) {
    Map<String, dynamic> data = json.decode(jsonText);
    final response = CategoryContentCollectionResponse.fromJson(data);
    if (response.key == givenKey) {
      return true;
    } else {
      return false;
    }
  }

  // Storage 데이터 삭제 (초기화)
  Future<void> _deleteLocalStorageField() async {
    await _localStorageService.deleteData(
        fieldName: 'categoryCollection$currentPage',);
  }

  // Paging Controller 데이터 추가
  Future<void> _appendData() async {
    final response = await _staticContentRepository
        .loadCategoryContentCollection(currentPage);
    return response.fold(
      onSuccess: (data) {
        final bool isLastPage = currentPage >= 2;
        if (isLastPage) {
          isPagingAvailable = false;
          pagingController.appendLastPage(data.items);
          disposeController(); // 더 이상 페이징할 데이터가 없으면 컨트롤러를 dispose
        } else {
          currentPage = currentPage + 1;
          pagingController.appendPage(data.items, currentPage + 1);
        }
      },
      onFailure: (e) {
        log('=== LoadCachedCategoryContentUseCase / 2-c) / api 호출 실패 \n $e');

        return null;
      },
    );
  }

  /// UseCase init메소드
  /// pagingController event listen 설정
  void initUseCase() {
    pagingController.addPageRequestListener((pageKey) {
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 50), _fetchPage);
    });
  }

  Future<void> _fetchPage() async {
    // 최대 불러올 수 있는 페이지 이미 다 불러왔다면 메소드 종료
    if (currentPage > 2) {
      return;
    }

    final Object? localData = await _localStorageService.getData(
        fieldName: 'categoryCollection$currentPage',);

    final String? keyResponse =
        _contentService.returnCategoryContentKey(currentPage);

    /// 한 가지 조건으로 분기됨
    /// 로컬 데이터가 있고
    /// 로컬에 저장되어 있는 키가 최신 키라면
    /// Local Storage 데이터를 초기화하지 않음
    if (localData.hasData &&
        _isRecentKey(
            jsonText: localData.toString(), givenKey: keyResponse ?? '',)) {
      await _appendData();
    }

    /// 로컬에 데이터가 없다면,
    /// 그리고 최신화 된 키가 아니라면
    /// Storage 데이터 삭제 및 초기화
    else {
      await _deleteLocalStorageField();
      await _appendData();
    }
  }

  void disposeController() {
    pagingController.dispose();
  }
}
