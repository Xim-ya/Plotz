// 스와이퍼 아이템 Scaffold
import 'package:uppercut_fantube/utilities/index.dart';

class ExploreSwiperItemScaffold extends StatelessWidget {
  const ExploreSwiperItemScaffold(
      {Key? key,
        required this.backdropImg,
        required this.contentInfoView,
        required this.channelInfoView})
      : super(key: key);

  final Widget backdropImg;
  final List<Widget> contentInfoView;
  final List<Widget> channelInfoView;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: backdropImg,
        ),
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black, Colors.transparent, AppColor.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: <double>[0.06, 0.3, 0.92],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Padding(
            padding: AppInset.horizontal16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ...contentInfoView,
              ],
            ),
          ),
        ),
      ],
    );
  }
}