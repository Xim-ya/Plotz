// 스와이퍼 아이템 Scaffold
import 'package:uppercut_fantube/utilities/index.dart';

class ExploreSwiperItemScaffold extends StatelessWidget {
  const ExploreSwiperItemScaffold(
      {Key? key,
      required this.backdropImg,
      required this.carouselBuilder,
})
      : super(key: key);

  final Widget backdropImg;
  final Widget carouselBuilder;


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        carouselBuilder,
        Positioned(
          top: SizeConfig.to.statusBarHeight + 16,
          right: 0,
          child: MaterialButton(
            minWidth: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            height: 0,
            padding: const EdgeInsets.all(6),
            onPressed: () {},
            child: const Icon(
              Icons.refresh,
              size: 28,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
