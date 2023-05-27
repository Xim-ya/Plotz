import 'package:soon_sak/presentation/common/skeleton_box.dart';
import 'package:soon_sak/utilities/index.dart';

class CurationGridItemView extends StatelessWidget {
  const CurationGridItemView({
    Key? key,
    required this.posterImgUrl,
    required this.curatorProfileImgUrl,
    required this.curatorName,
  }) : super(key: key);

  final String? posterImgUrl;
  final String? curatorProfileImgUrl;
  final String? curatorName;

  factory CurationGridItemView.createSkeleton() => const CurationGridItemView(
      posterImgUrl: null, curatorProfileImgUrl: null, curatorName: null);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        if (curatorName.hasData) ...[
          // 컨텐츠 포스터 이미지
          Positioned.fill(
            child: LinearLayeredPosterImg(
              usedInCuration: true,
              linearColor: Colors.black.withOpacity(0.8),
              linearStep: const [0.1, 0.2, 1],
              imgUrl: posterImgUrl,
            ),
          ),

          // 컨텐츠 요청 유저 정보
          Positioned(
            left: 10,
            bottom: 10,
            child: Row(
              children: <Widget>[
                // 프로필 이미지
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                  child: RoundProfileImg(
                    size: 36,
                    imgUrl: curatorProfileImgUrl,
                  ),
                ),
                AppSpace.size4,
                // 프로필 이미지
                SizedBox(
                  width: (SizeConfig.to.screenWidth - 32) / 2 - 56,
                  child: Text(
                    curatorName.hasData ? '$curatorName님' : '익명유저',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.title3,
                  ),
                )
              ],
            ),
          ),
        ]
        // 스켈레톤
        else ...[
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
        ]
      ],
    );
  }
}
