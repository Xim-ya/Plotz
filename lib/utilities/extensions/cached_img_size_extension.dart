import 'package:flutter/cupertino.dart';

extension CachedImgSizeDoubleExtension on double {
  int cacheSize(BuildContext context) {
    return (this * MediaQuery.of(context).devicePixelRatio).round();
  }
}


extension CachedImgSizeIntExtension on int {
  int cacheSize(BuildContext context) {
    return (this * MediaQuery.of(context).devicePixelRatio).round();
  }
}
