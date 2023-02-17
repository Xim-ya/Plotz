import 'package:soon_sak/utilities/index.dart';

class CurationGridItemSkeletonView extends StatelessWidget {
  const CurationGridItemSkeletonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[


        // 컨텐츠 포스터 이미지
        const Positioned.fill(
          child: ClipRRect(
            child: AspectRatio(
              aspectRatio: 2 / 3,
              child: SkeletonBox(),
            ),
          ),
        ),


        // 컨텐츠 요청 유저 정보
        Positioned(
          left: 10,
          bottom: 10,
          child: Row(
            children: const <Widget>[
              // 프로필 이미지
              SkeletonBox(
                height: 36,
                width: 36,
                borderRadius: 100,
              ),

              AppSpace.size6,
              // 프로필 이미지
              SkeletonBox(
                height: 20,
                width: 38,
                borderRadius: 4,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
