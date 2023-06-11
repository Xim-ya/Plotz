import 'package:soon_sak/app/di/binding.dart';
import 'package:soon_sak/domain/useCase/search/search_paged_content_use_case.dart';
import 'package:soon_sak/presentation/screens/search/localWidget/search_scaffold_controller.dart';
import 'package:soon_sak/utilities/index.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    super.dependencies();

    locator.registerFactory(
      () => SearchViewModel(
          searchHandler: locator<SearchedPagedContentUseCase>(),
          contentRepository: locator<ContentRepository>(),
          userService: locator<UserService>()),
    );

    locator.registerFactory(() =>
        SearchScaffoldController(searchViewModel: locator<SearchViewModel>()));

    locator.registerLazySingleton(() => SearchedPagedContentUseCase(
        tmdbRepository: locator<TmdbRepository>()));
  }

  @override
  void unRegisterDependencies() {
    super.unRegisterDependencies();

    locator.unregister<SearchViewModel>();
    locator.unregister<SearchScaffoldController>();
    locator.unregister<SearchedPagedContentUseCase>();
  }
}
