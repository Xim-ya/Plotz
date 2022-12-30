import 'package:uppercut_fantube/presentation/common/skeleton_box.dart';
import 'package:uppercut_fantube/utilities/index.dart';

/* Created By Ximya - 2022.12.30
*  채널 프로필 이미지 & 채널명 & 구독자 수
*  위 정보를 구성되어 있는 뷰
*  기본적인 스켈레톤 처리도 진행함
* */

class ChannelInfoView extends StatelessWidget {
  const ChannelInfoView(
      {Key? key,
      this.imgSize = 48,
      required this.channelImgUrl,
      required this.channelName,
      required this.subscriberCount})
      : super(key: key);

  final String? channelImgUrl;
  final String? channelName;
  final int? subscriberCount;
  final double imgSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 채널 프로필 이미지
        if (channelImgUrl.hasData)
          RoundProfileImg(
            size: imgSize,
            imgUrl: channelImgUrl,
          )
        else
          SkeletonBox(
            width: imgSize,
            height: imgSize,
            borderRadius: 100,
          ),
        AppSpace.size10,
        // 채널명
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (channelName.hasData)
              Text(
                channelName!,
                style: AppTextStyle.headline3,
              )
            else ...[
              const SkeletonBox(
                width: 80,
                height: 20,
              ),
              AppSpace.size2,
            ],
            if (subscriberCount.hasData)
              Text(
                '구독자 ${Formatter.formatViewAndLikeCount(subscriberCount)}명',
                style: AppTextStyle.body1.copyWith(color: AppColor.lightGrey),
              )
            else
              const SkeletonBox(
                width: 180,
                height: 22,
              ),
          ],
        ),
      ],
    );
  }
}
