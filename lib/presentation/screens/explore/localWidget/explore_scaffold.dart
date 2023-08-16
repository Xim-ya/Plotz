import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/utilities/index.dart';

class ExploreScaffold extends StatelessWidget {
  const ExploreScaffold({
    Key? key,
    required this.stream,
    required this.carouselController,
    required this.onSwiperChanged,
    required this.onContentTapped,
    required this.fullSizedPosterImg,
    required this.contentInfoView,
  }) : super(key: key);

  final Stream<List<ExploreContent>>? stream;
  final CarouselController carouselController;
  final Function(int) onSwiperChanged;
  final Function(int) onContentTapped;
  final Widget Function(ExploreContent?, BuildContext) fullSizedPosterImg;
  final Widget Function(ExploreContent?) contentInfoView;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ExploreContent>>(
      stream: stream,
      builder: (context, snapshot) {
        return CarouselSlider.builder(
          carouselController: carouselController,
          itemCount: snapshot.data?.length ?? 1,
          options: CarouselOptions(
            onPageChanged: (index, _) {
              onSwiperChanged(index);
            },
            disableCenter: true,
            height: double.infinity,
            scrollDirection: Axis.vertical,
            enableInfiniteScroll: false,
            viewportFraction: 1,
          ),
          itemBuilder:
              (BuildContext context, int parentIndex, int pageViewIndex) {
            final contentItem = snapshot.data?[pageViewIndex];
            return GestureDetector(
              onTap: () {
                if (snapshot.data == null) return;
                onContentTapped(pageViewIndex);
              },
              child: Stack(
                children: [
                  // 포스터 이미지
                  fullSizedPosterImg(contentItem, context),
                  // 하단 Gradient Container
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: SizeConfig.to.ratioHeight(208),
                      width: SizeConfig.to.screenWidth,
                      decoration: const BoxDecoration(
                          gradient: AppGradient.exBottomToTop),
                    ),
                  ),

                  // 상단 StatusBar Container
                  Positioned(
                    top: 0,
                    child: Container(
                      height: SizeConfig.to.statusBarHeight,
                      width: SizeConfig.to.screenWidth,
                      color: AppColor.black,
                    ),
                  ),

                  // 상단 Gradient Container
                  Positioned(
                    top: SizeConfig.to.statusBarHeight,
                    child: Container(
                      height: SizeConfig.to.ratioHeight(88),
                      width: SizeConfig.to.screenWidth,
                      decoration: const BoxDecoration(
                        gradient: AppGradient.exTopBottom,
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 0,
                    child: Padding(
                      padding: AppInset.horizontal16,
                      child: contentInfoView(contentItem),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
