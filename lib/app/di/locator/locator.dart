import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.I;

void unregisterIfRegistered<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}
