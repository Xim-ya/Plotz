import 'package:flutter/material.dart';
import 'dart:math' as math;

/* Created By Ximya - 2022.11.07
*  Sliver Scroll 로직에서 사용되는 Widget
*  Scroll 될 때 해당 위젯의 사이즈를 기준으로 Sticky(고정)됨
* */

class StickyDelegateContainer extends SliverPersistentHeaderDelegate {
  StickyDelegateContainer({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(StickyDelegateContainer oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
