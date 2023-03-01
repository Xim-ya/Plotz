import 'package:soon_sak/utilities/index.dart';

extension DeterminContentType on TabLoadingState {
  bool get isInitState {
    return this == TabLoadingState.initState ? true : false;
  }

  bool get isLoading {
    return this == TabLoadingState.loading ? true : false;
  }

  bool get isDone {
    return this == TabLoadingState.done ? true : false;
  }
}
