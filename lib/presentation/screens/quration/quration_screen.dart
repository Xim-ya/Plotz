import 'package:polygon/polygon.dart';
import 'package:uppercut_fantube/presentation/screens/quration/quration_view_model.dart';
import 'package:uppercut_fantube/utilities/index.dart';
import 'dart:math' as math; // import this

class QurationScreen extends BaseScreen<QurationViewModel> {
  const QurationScreen({Key? key}) : super(key: key);

  @override
  Widget buildScreen(BuildContext context) {
    const polygon = Polygon([
      Offset(-1, -0.72), // top left
      Offset(1, -1), // top right
      Offset(1, 1), // bottom right
      Offset(-1, 1), // bottom left

    ]);
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
              style:
                  AppTextStyle.headline1.copyWith(color: AppColor.mixedWhite),
            ),
            AppSpace.size22,
            Row(
              children: [
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 163/148,
                    child: DecoratedBox(
                      decoration: ShapeDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              '/f2PVrphK0u81ES256lw3oAZuF3x.jpg'.prefixTmdbImgPath),
                          fit: BoxFit.cover,
                        ),
                        shape: PolygonBorder(
                          polygon: PolygonPainter(polygon).polygon,
                          radius: 24,
                          borderAlign: BorderAlign.outside,
                        ),
                      ),
                    ),
                  ),
                ),
                AppSpace.size16,
                Expanded(
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(math.pi),
                    child: AspectRatio(
                      aspectRatio: 163/148,
                      child: DecoratedBox(
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                '/f2PVrphK0u81ES256lw3oAZuF3x.jpg'.prefixTmdbImgPath),
                            fit: BoxFit.cover,
                          ),
                          shape: PolygonBorder(
                            polygon: PolygonPainter(polygon).polygon,
                            radius: 24,
                            borderAlign: BorderAlign.outside,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),



            // 큐레이션 컨텐츠 등록 버튼 (드라마, 영화)
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