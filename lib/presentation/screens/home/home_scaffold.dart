import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:uppercut_fantube/app/config/app_space_config.dart';
import 'package:uppercut_fantube/app/config/font_config.dart';
import 'package:uppercut_fantube/presentation/common/icon_ink_well_button.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class HomeScaffold extends StatelessWidget {
  const HomeScaffold({Key? key, required this.animationAppbar, required this.scrollController, required this.body, required this.appBarHeight, required this.stackedGradientPosterBg, required this.contentSlider})
      : super(key: key);

  final List<Widget> animationAppbar;
  final List<Widget> stackedGradientPosterBg;
  final Widget contentSlider;
  final Widget body;
  final ScrollController scrollController;
  final double appBarHeight;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.zero,
      child: Stack(
        children: [
          SingleChildScrollView(
            controller: scrollController,
            child:  Stack(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    for (final widget in stackedGradientPosterBg) widget,
                    /* 컨텐츠 섹션 */
                    Column(
                      children: [
                        SizedBox(height: appBarHeight), // 커스텀 앱바와 간격을 맞추기 위한 위젯
                        AppSpace.size72,
                        contentSlider,
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          for (final widget in animationAppbar) widget,
        ],
      ),
    );
  }
}
