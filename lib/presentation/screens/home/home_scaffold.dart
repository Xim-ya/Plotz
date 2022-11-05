import 'package:uppercut_fantube/utilities/index.dart';

class HomeScaffold extends StatelessWidget {
  const HomeScaffold({Key? key, required this.animationAppbar, required this.scrollController, required this.body})
      : super(key: key);

  final List<Widget> animationAppbar;
  final Widget body;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.zero,
      child: Stack(
        children: [
          SingleChildScrollView(
            controller: scrollController,
            child: body,
          ),

          for (final tab in animationAppbar) tab,
        ],
      ),
    );
  }
}
