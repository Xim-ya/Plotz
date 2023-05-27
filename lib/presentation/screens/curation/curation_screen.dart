import 'package:provider/provider.dart';
import 'package:soon_sak/presentation/base/new_base_view.dart';
import 'package:soon_sak/utilities/index.dart';

class CurationScreen extends NewBaseScreen<CurationViewModel> {
  const CurationScreen({Key? key}) : super(key: key);

  @override
  Widget buildScreen(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: AppInset.horizontal16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AppSpace.size34,
            // 리딩 문구
            Text(
              '재미있는\n리뷰 콘텐츠를 등록해주세요!',
              style: AppTextStyle.headline1,
            ),
            AppSpace.size22,
            // 큐레이션 컨텐츠 등록 버튼 (드라마, 영화)
            Selector<CurationViewModel, RandomImg>(
              selector: (context, vm) => vm.randomContentImg,
              builder: (context, imgPath, _) {
                return Row(
                  children: [
                    StartCurationButton(
                      imgPath: imgPath.tvImgPath,
                      contentType: ContentType.tv,
                      onBtnTapped: () {
                        vm(context)
                            .routeToRegister(contentType: ContentType.tv);
                      },
                    ),
                    AppSpace.size16,
                    StartCurationButton(
                      imgPath: imgPath.movieImgPath,
                      contentType: ContentType.movie,
                      onBtnTapped: () {
                        vm(context)
                            .routeToRegister(contentType: ContentType.movie);
                      },
                    ),
                  ],
                );
              },
            ),
            AppSpace.size72,

            // 진행중인 큐레이션 목록
            Text(
              '진행중인 큐레이션',
              style: AppTextStyle.headline2.copyWith(
                fontSize: 22,
              ),
            ),
            AppSpace.size10,
            Consumer<CurationViewModel>(builder: (context, vm, _) {
              if (vmS(context, (vm) => vm.isInProgressCurationEmpty)) {
                return Text(
                  '현재 진행중인 큐레이션이 없어요',
                  style: AppTextStyle.body1.copyWith(color: AppColor.lightGrey),
                );
              } else {
                return GridView.builder(
                  padding: AppInset.bottom46,
                  shrinkWrap: true,
                  itemCount: vmS<int>(context, (vm) => vm.curationListLength),
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverQuiltedGridDelegate(
                    crossAxisCount: 14,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    repeatPattern: QuiltedGridRepeatPattern.inverted,
                    pattern: [
                      const QuiltedGridTile(9, 7),
                      const QuiltedGridTile(8, 7),
                    ],
                  ),
                  itemBuilder: (BuildContext _, int index) {
                    return Builder(builder: (context) {
                      final itemList = vmS<List<CurationContent>>(
                          context, (vm) => vm.inProgressCurations);
                      if (itemList.isNotEmpty) {
                        final item = itemList[index];
                        return CurationGridItemView(
                          posterImgUrl: item.posterImgUrl,
                          curatorProfileImgUrl: item.curatorProfileImgUrl,
                          curatorName: item.curatorName,
                        );
                      } else {
                        return CurationGridItemView.createSkeleton();
                      }
                    });
                  },
                );
              }
            })
          ],
        ),
      ),
    );
  }

  @override
  CurationViewModel createViewModel(BuildContext context) =>
      locator<CurationViewModel>();
}

class PolygonPainter extends CustomPainter {
  PolygonPainter(this.polygon);

  final Polygon polygon;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(
      polygon.computePath(rect: Offset.zero & size),
      Paint()..color = Colors.yellow.shade800,
    );
  }

  @override
  bool shouldRepaint(PolygonPainter oldDelegate) {
    return oldDelegate.polygon != polygon;
  }
}
