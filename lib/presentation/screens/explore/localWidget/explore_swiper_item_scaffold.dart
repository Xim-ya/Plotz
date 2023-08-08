// 스와이퍼 아이템 Scaffold
import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/utilities/index.dart';

class ExploreSwiperItemScaffold extends StatelessWidget {
  const ExploreSwiperItemScaffold({
    Key? key,
    required this.carouselBuilder,
    required this.actionButtons,
  }) : super(key: key);

  final Widget carouselBuilder;
  final Widget actionButtons;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        carouselBuilder,
      ],
    );
  }
}
