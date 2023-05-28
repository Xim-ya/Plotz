import 'package:soon_sak/utilities/index.dart';
import 'dart:math' as math;

/** Created By Ximya - 022.01.24
 *  다각형(polygon) 형태로 구성되어 있는 버튼 UI
 *  다각형 UI는 Painter로 그려짐.
 *
 *  각 [ContentType]에 따라
 *  랜덤으로 컨텐츠 이미지가 보여짐.
 * */

class StartCurationButton extends StatelessWidget {
  const StartCurationButton(
      {Key? key, required this.contentType, required this.onBtnTapped, required this.imgPath,})
      : super(key: key);

  final ContentType contentType;
  final VoidCallback onBtnTapped;
  final String imgPath;



  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(contentType.isTv ? 0 : math.pi),
        child: Stack(
          children: <Widget>[
            // Shadow Box
            Positioned.fill(
              child: Container(
                height: 74,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(100),
                    topRight: Radius.circular(100),
                    bottomRight: Radius.circular(24),
                    bottomLeft: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 4,
                      offset: const Offset(0, 4), // changes position of shadow
                    ),
                  ],
                ),
              ),
            ),
            // 다각형 이미지 버튼
            GestureDetector(
              onTap: onBtnTapped,
              child: AspectRatio(
                aspectRatio: 163 / 148,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: DecoratedBox(
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image:
                            AssetImage('assets/images/$imgPath'),
                        fit: BoxFit.cover,
                      ),
                      shape: const PolygonBorder(
                        polygon: polygonOffset,
                        radius: 24,
                        borderAlign: BorderAlign.outside,
                      ),
                    ),
                    child: Container(
                      padding: AppInset.left10 + AppInset.bottom6,
                      alignment: Alignment.bottomLeft,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.transparent,
                            Colors.black,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: <double>[0.0, 0.4, 1.0],
                        ),
                      ),
                      child: Transform(
                        alignment: Alignment.center,
                        transform:
                            Matrix4.rotationY(contentType.isTv ? 0 : math.pi),
                        child: Text(
                          contentType.isTv ? '드라마' : '영화',
                          style: AppTextStyle.headline3
                              .copyWith(color: AppColor.lightGrey),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const List<String> movieImgPathList = [
  'movie_content_img_1.png',
  'movie_content_img_2.png',
  'movie_content_img_3.png',
];

const List<String> tvImgPathList = [
  'tv_content_img_1.png',
  'tv_content_img_2.png',
  'tv_content_img_3.png',
  'tv_content_img_4.png',
];

const polygonOffset = Polygon([
  Offset(1, -1),
  Offset(1, 1),
  Offset(-1, 1),
  Offset(-1, -0.72),
]);
