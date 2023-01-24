import 'package:polygon/polygon.dart';
import 'package:uppercut_fantube/utilities/extensions/determine_content_type.dart';
import 'package:uppercut_fantube/utilities/extensions/random_list_item_extension.dart';
import 'package:uppercut_fantube/utilities/index.dart';
import 'dart:math' as math;

class StartQurationButton extends StatelessWidget {
  const StartQurationButton(
      {Key? key, required this.contentType, required this.onBtnTapped})
      : super(key: key);

  final ContentType contentType;
  final VoidCallback? onBtnTapped;

  String randomImgGenerator() {
    final List<String> imgPathList =
        contentType.isTv ? tvImgPathList : movieImgPathList;
    String randomImgPath = imgPathList.randomItem();
    return randomImgPath;
  }

  @override
  Widget build(BuildContext context) {
    randomImgGenerator();
    return Expanded(
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(contentType.isTv ? 0 : math.pi),
        child: GestureDetector(
          onTap: onBtnTapped,
          child: AspectRatio(
            aspectRatio: 163 / 148,
            child: DecoratedBox(
              decoration: ShapeDecoration(
                shadows: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: const Offset(0, 4), // changes position of shadow
                  ),
                ],
                image: DecorationImage(
                  image: AssetImage('assets/images/${randomImgGenerator()}'),
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
                      AppColor.black
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: <double>[0.0, 0.68, 1.0],
                  ),
                ),
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(contentType.isTv ? 0 : math.pi),
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
    );
  }
}

const List<String> movieImgPathList = [
  'movie_content_img_1.jpeg',
  'movie_content_img_2.jpeg',
  'movie_content_img_3.jpeg',
];

const List<String> tvImgPathList = [
  'tv_content_img_1.jpeg',
  'tv_content_img_2.jpeg',
  'tv_content_img_3.jpg',
  'tv_content_img_4.jpeg',
];

const polygonOffset = Polygon([
  Offset(1, -1),
  Offset(1, 1),
  Offset(-1, 1),
  Offset(-1, -0.72),
]);
