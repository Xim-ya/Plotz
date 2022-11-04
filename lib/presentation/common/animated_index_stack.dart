import 'package:flutter/material.dart';

/** Created By Ximya - 2022.11.04
 * - [IndexStack] 위젯을 사용할 때 페이지 전환 애니메이션이 제한되는 문제점을 보완히기 위해 만들어진 모듈
 * - 여러 애니메이션이 적용 및 트리거 되기 위해 [SingleTickerProviderStateMixin]을 사용
 * - Fade 및 Scale 되는 효과를 적용함.
 * - [https://gist.github.com/diegoveloper/1cd23e79a31d0c18a67424f0cbdfd7ad] <- 해당 깃허브 레포를 참고함.
 * */

class AnimatedIndexedStack extends StatefulWidget {
  final int index;
  final List<Widget> children;

  const AnimatedIndexedStack({
    Key? key,
    required this.index,
    required this.children,
  }) : super(key: key);

  @override
  _AnimatedIndexedStackState createState() => _AnimatedIndexedStackState();
}

class _AnimatedIndexedStackState extends State<AnimatedIndexedStack>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late int _index;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    );

    _index = widget.index;
    _controller.forward();
    super.initState();
  }

  @override
  void didUpdateWidget(AnimatedIndexedStack oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.index != _index) {
      _controller.reverse().then((_) {
        setState(() => _index = widget.index);
        _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _controller.value,
          child: Transform.scale(
            scale: 1.015 - (_controller.value * 0.015),
            child: child,
          ),
        );
      },
      child: IndexedStack(
        index: _index,
        children: widget.children,
      ),
    );
  }
}