import 'package:soon_sak/utilities/index.dart';

class BannerItemView extends StatelessWidget {
  const BannerItemView({Key? key, required this.title, required this.description, required this.onItemTapped, required this.imgUrl}) : super(key: key);

  final String title;
  final String description;
  final String imgUrl;
  final VoidCallback onItemTapped;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            child: Text(
              title,
              style: AppTextStyle.headline2
                  .copyWith(color: Colors.white),
            ),
          ),
          AppSpace.size2,
          Text(
            '$description\n',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: AppTextStyle.headline3
                .copyWith(color: AppColor.lightGrey),
          ),
          AppSpace.size8,
          // 유튜브 썸네일 이미지
          VideoThumbnailImgWithPlayerBtn(
            onPlayerBtnClicked: onItemTapped,
            posterImgUrl: imgUrl,
          ),
        ],
      ),
    );
  }
}
