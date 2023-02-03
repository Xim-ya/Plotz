import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:polygon/polygon.dart';
import 'package:uppercut_fantube/presentation/screens/quration/localWidget/start_quration_button.dart';
import 'package:uppercut_fantube/presentation/screens/quration/quration_view_model.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class QurationScreen extends BaseScreen<QurationViewModel> {
  const QurationScreen({Key? key}) : super(key: key);

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
              '재미있는\n리뷰 컨텐츠를 등록해주세요!',
              style: AppTextStyle.headline1,
            ),
            AppSpace.size22,



            // 큐레이션 컨텐츠 등록 버튼 (드라마, 영화)
            Row(
              children: [
                StartQurationButton(
                  imgPath: vm.randomContentImg.tvImgPath,
                  contentType: ContentType.tv,
                  onBtnTapped: () {
                    vm.routeToRegister(contentType: ContentType.tv);
                  },
                ),
                AppSpace.size16,
                StartQurationButton(
                  imgPath: vm.randomContentImg.movieImgPath,
                  contentType: ContentType.movie,
                  onBtnTapped: () {
                    vm.routeToRegister(contentType: ContentType.movie);
                  },
                ),
              ],
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
            GridView.builder(
              shrinkWrap: true,
              itemCount: 19,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverQuiltedGridDelegate(
                crossAxisCount: 14,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                repeatPattern: QuiltedGridRepeatPattern.inverted,
                pattern: [
                  QuiltedGridTile(9, 7),
                  QuiltedGridTile(8, 7),
                ],
              ),
              itemBuilder: (BuildContext context, int index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: const ContentPostItem(
                    imgUrl: '/f2PVrphK0u81ES256lw3oAZuF3x.jpg',
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
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
