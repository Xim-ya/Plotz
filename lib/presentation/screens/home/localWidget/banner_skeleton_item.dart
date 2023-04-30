import 'package:soon_sak/utilities/index.dart';


class BannerSkeletonItem extends StatelessWidget {
  const BannerSkeletonItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 84,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                SkeletonBox(
                  borderRadius: 4,
                  margin: AppInset.vertical2,
                  width: 100,
                  height: 26,
                ),
                AppSpace.size8,
                SkeletonBox(
                  borderRadius: 4,
                  margin: AppInset.vertical2,
                  width: double.infinity,
                  height: 18,
                ),
                AppSpace.size10,
              ],
            ),
          ),
          // 배너 이미지
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: const AspectRatio(
                aspectRatio: 16 / 9,
                child: SkeletonBox(),
            ),
          ),
        ],
      ),
    );
  }
}

