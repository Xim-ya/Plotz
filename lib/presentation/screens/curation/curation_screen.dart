import 'package:soon_sak/utilities/index.dart';

class CurationScreen extends BaseScreen<CurationViewModel> {
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
              '재미있는\n리뷰 컨텐츠를 등록해주세요!',
              style: AppTextStyle.headline1,
            ),
            AppSpace.size22,
            // 큐레이션 컨텐츠 등록 버튼 (드라마, 영화)
            Row(
              children: [
                StartCurationButton(
                  imgPath: vm.randomContentImg.tvImgPath,
                  contentType: ContentType.tv,
                  onBtnTapped: () {
                    vm.routeToRegister(contentType: ContentType.tv);
                  },
                ),
                AppSpace.size16,
                StartCurationButton(
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
                  const QuiltedGridTile(9, 7),
                  const QuiltedGridTile(8, 7),
                ],
              ),
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  children: <Widget>[
                    // 컨텐츠 포스터 이미지
                    Positioned.fill(
                      child: LinearLayeredPosterImg(
                          linearColor: Colors.black.withOpacity(0.8),
                          linearStep: const [0.1, 0.2, 1],
                          imgUrl: '/f2PVrphK0u81ES256lw3oAZuF3x.jpg'),
                    ),
                    // 컨텐츠 요청 유저 정보
                    Positioned(
                      left: 10,
                      bottom: 10,
                      child: Row(
                        children: <Widget>[
                          // 프로필 이미지
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://memez861.cdn-nhncommerce.com/data/category/scm_342.jpg',
                              height: 36,
                            ),
                          ),

                          // 프로필 이미지
                          Text(
                            '${'심야'}님',
                            style: AppTextStyle.title3,
                          )
                        ],
                      ),
                    ),
                  ],
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
