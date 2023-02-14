// 스와이퍼 아이템 Scaffold
import 'package:soon_sak/utilities/index.dart';

class ExploreSwiperItemScaffold extends StatelessWidget {
  const ExploreSwiperItemScaffold({
    Key? key,
    required this.backdropImg,
    required this.carouselBuilder,
    required this.actionButtons,
  }) : super(key: key);

  final Widget backdropImg;
  final Widget carouselBuilder;
  final Widget actionButtons;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        carouselBuilder,
        Positioned(
          top: SizeConfig.to.statusBarHeight + 16,
          right: 0,
          child: actionButtons,
        ),
      ],
    );
  }
}
