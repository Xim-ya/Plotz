import 'package:soon_sak/utilities/index.dart';

class CurationGridItemView extends StatelessWidget {
  const CurationGridItemView(
      {Key? key,
      required this.posterImgUrl,
      required this.curatorProfileImgUrl,
      required this.curatorName})
      : super(key: key);

  final String posterImgUrl;
  final String curatorProfileImgUrl;
  final String curatorName;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // 컨텐츠 포스터 이미지
        Positioned.fill(
          child: LinearLayeredPosterImg(
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    imageUrl: curatorProfileImgUrl,
                    height: 36,
                  ),
                ),
              ),
              AppSpace.size4,
              // 프로필 이미지
              SizedBox(
                width: (SizeConfig.to.screenWidth - 32) / 2 - 56,
                child: Text(
                  '$curatorName님',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.title3,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
