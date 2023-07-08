// import 'package:soon_sak/utilities/index_prev.dart';
//
//
// class SearchPagedContentImpl
//     with SearchHandlerMixin, PagingSearchHandlerMixin
//     implements SearchPagedContentUseCase {
//   SearchPagedContentImpl(this._repository);
//
//   final TmdbRepository _repository;
//    Content? _selectedContent ;
//
//   @override
//   String get searchedKeyword => term;
//
//   @override
//   TmdbRepository get repository => _repository;
//
//   @override
//   Content? get selectedContent => _selectedContent;
//   Timer? _debounce;
//
//   @override
//   bool get isPagingAllowed => getPagingAvailableState(term);
//
//   /* Intents */
//   // 검색어가 입력되었을 때
//   @override
//   Future<void> onSearchTermEntered() async {
//     toggleCloseBtn();
//     if (isPagingAllowed) {
//       // Debounce delay 설정
//       if (_debounce?.isActive ?? false) _debounce!.cancel();
//       _debounce =
//           Timer(const Duration(milliseconds: 300), pagingController.refresh);
//       _selectedContent = null;
//     }
//   }
//
//   // 검색된 컨텐츠가 선택 되었을 때
//   @override
//   void onSearchedContentTapped(
//       {required SearchedContent content, required ContentType contentType,}) {
//     _selectedContent = Content(
//       id: content.contentId,
//       type: contentType,
//       detail: ContentDetail(
//         title: content.title,
//         posterImgUrl: content.posterImgUrl,
//         releaseDate: content.releaseDate,
//       ),
//     );
//   }
//
//   @override
//   // TODO: implement textEditingController
//   TextEditingController get textEditingController => throw UnimplementedError();
//
//   @override
//   // TODO: implement focusNode
//   FocusNode get focusNode => throw UnimplementedError();
//
//   @override
//   // TODO: implement showRoundCloseBtn
//   bool get showRoundCloseBtn => throw UnimplementedError();
// }
