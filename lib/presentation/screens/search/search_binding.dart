import 'package:soon_sak/app/di/custom_binding.dart';
import 'package:soon_sak/domain/useCase/search/new_search_paged_content_use_case.dart';
import 'package:soon_sak/presentation/screens/search/localWidget/search_scaffold_controller.dart';
import 'package:soon_sak/utilities/index.dart';

class SearchBinding extends CustomBindings {
  @override
  void dependencies() {
    locator.registerFactory(() => SearchViewModel(
        searchHandler: locator<NewSearchedPagedContentUseCase>(),
        contentRepository: locator<ContentRepository>(),
        userService: locator<UserService>()));

    locator.registerFactory(() =>
        SearchScaffoldController(searchViewModel: locator<SearchViewModel>()));
  }
}
