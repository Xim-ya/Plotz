import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/presentation/index.dart';

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
