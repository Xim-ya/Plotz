import 'package:uppercut_fantube/utilities/index.dart';

class BannerSkeletonItem extends StatelessWidget {
  const BannerSkeletonItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.symmetric(horizontal: 4)  + EdgeInsets.only(top: 10),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:   <Widget>[
           const SkeletonBox(
            borderRadius: 4,
            margin: AppInset.vertical2,
            width: 100,
            height: 26,
          ),
          AppSpace.size4,
          const SkeletonBox(
            borderRadius: 4,
            margin: AppInset.vertical2,
            width: double.infinity,
            height: 18,
          ),
          AppSpace.size26,
          // 유튜브 썸네일 이미지
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: const AspectRatio(
              aspectRatio: 16 / 9,
              child: SkeletonBox()
            ),
          ),
        ],
      ),
    );
  }
}
