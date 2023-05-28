import 'package:soon_sak/utilities/index.dart';

extension DeterminContentType on ViewModelLoadingState {
  bool get isInitState {
    return this == ViewModelLoadingState.initState ? true : false;
  }

  bool get isLoading {
    return this == ViewModelLoadingState.loading ? true : false;
  }

  bool get isDone {
    return this == ViewModelLoadingState.done ? true : false;
  }
}
