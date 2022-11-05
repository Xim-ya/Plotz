import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:uppercut_fantube/app/config/app_space_config.dart';
import 'package:uppercut_fantube/app/config/font_config.dart';
import 'package:uppercut_fantube/presentation/common/icon_ink_well_button.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class HomeScaffold extends StatelessWidget {
  const HomeScaffold({Key? key, required this.animationAppbar, required this.scrollController, required this.body, required this.appBarHeight, required this.stackedGradientPosterBg, required this.topExposedContentSlider, required this.topTenContentSlider})
      : super(key: key);

  final List<Widget> animationAppbar;
  final List<Widget> stackedGradientPosterBg;
  final Widget topExposedContentSlider;
  final List<Widget> topTenContentSlider;
  final List<Widget> body;
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
                  ],
                ),
                /* 컨텐츠 섹션 */
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: appBarHeight), // 커스텀 앱바와 간격을 맞추기 위한 위젯
                    AppSpace.size72,
                    topExposedContentSlider, // 상단 대표 컨텐츠 슬라이더
                    for (final widget in topTenContentSlider) widget, // Top10 컨텐츠 슬라이더
                    for (final widget in body) widget,
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
