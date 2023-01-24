import 'package:polygon/polygon.dart';
import 'package:uppercut_fantube/presentation/screens/quration/localWidget/start_quration_button.dart';
import 'package:uppercut_fantube/presentation/screens/quration/quration_view_model.dart';
import 'package:uppercut_fantube/utilities/index.dart';
import 'dart:math' as math;

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
              children: const [
                StartQurationButton(
                  contentType: ContentType.tv,
                  onBtnTapped: null,
                ),
                AppSpace.size16,
                StartQurationButton(
                  contentType: ContentType.movie,
                  onBtnTapped: null,
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
