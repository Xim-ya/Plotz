import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/presentation/index.dart';
import 'package:soon_sak/utilities/index.dart';

class BannerItemView extends StatelessWidget {
  const BannerItemView(
      {Key? key,
      required this.title,
      required this.description,
      required this.onItemTapped,
      required this.imgUrl,})
      : super(key: key);

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
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 92,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: AppTextStyle.headline2.copyWith(color: Colors.white),
                ),
                AppSpace.size2,
                Text(
                  description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style:
                  AppTextStyle.headline3.copyWith(color: AppColor.lightGrey),
                ),
                AppSpace.size8,
              ],
            ),
          ),

          // 배너 이미지
          ImageViewWithPlayBtn(
            showPlayerBtn: false,
            onPlayerBtnClicked: onItemTapped,
            posterImgUrl: imgUrl,
          ),
        ],
      ),
    );
  }
}
