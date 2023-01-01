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
      children: <Widget>[
        CarouselSlider.builder(
            itemCount: 20,
            options: CarouselOptions(
              disableCenter: true,
              height: double.infinity,
              scrollDirection: Axis.vertical,
              enableInfiniteScroll: false,
              viewportFraction: 1,
            ),
            itemBuilder:
                (BuildContext context, int parentIndex, int pageViewIndex) {
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
                          colors: [
                            Colors.black,
                            Colors.transparent,
                            AppColor.black
                          ],
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
                          ...channelInfoView,
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
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
