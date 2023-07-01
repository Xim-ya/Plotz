import 'package:provider/provider.dart';
import 'package:soon_sak/presentation/common/image/content_poster_item_view.dart';
import 'package:soon_sak/utilities/index.dart';
import 'dart:math' as math;

class NewMyPageScreen extends BaseScreen<MyPageViewModel> {
  const NewMyPageScreen({Key? key}) : super(key: key);

  @override
  Widget buildScreen(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 60),
          // 상단 프로필 이미지
          StreamBuilder<UserModel>(
            stream: vm(context).userInfoSub.stream,
            builder: (context, snapshot) {
              return Column(
                children: <Widget>[
                  RoundProfileImg(
                    size: 90,
                    imgUrl: snapshot.data?.photoUrl,
                  ),
                  AppSpace.size16,
                  Text(
                    snapshot.data?.displayName ?? '-',
                    style: AppTextStyle.headline1
                        .copyWith(color: AppColor.mixedWhite),
                  ),
                ],
              );
            },
          ),
          AppSpace.size36,
          // 시청 기록
          Padding(
            padding: AppInset.left16,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '시청 기록',
                style: AppTextStyle.headline2,
              ),
            ),
          ),
          AppSpace.size8,
          StreamBuilder<List<UserWatchHistoryItem>?>(
            stream: vm(context).watchHistorySub.stream,
            builder: (context, snapshot) {
              final items = snapshot.data;
              return items.hasData && items!.isEmpty
                  ? Padding(
                      padding: AppInset.left16,
                      child: Text(
                        '시청 기록이 없어요',
                        style: AppTextStyle.body1
                            .copyWith(color: AppColor.lightGrey),
                      ),
                    )
                  : ContentPostSlider(
                      height: 160,
                      itemCount: items?.length ?? 5,
                      itemBuilder: (BuildContext context, int index) {
                        final item = items?[index];
                        if (item.hasData) {
                          return ContentPosterItemView(
                            imgUrl: item?.posterImgUrl,
                            title: item!.videoId,
                          );
                        } else {
                          return ContentPosterItemView.createSkeleton();
                        }
                      },
                    );
            },
          ),

          AppSpace.size48,
        ],
      ),
    );
  }

  Widget _curationProgressRowItem({
    required String title,
    required int count,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$count',
          style: AppTextStyle.headline3,
        ),
        Text(
          title,
          style: AppTextStyle.body2,
        ),
      ],
    );
  }

  @override
  MyPageViewModel createViewModel(BuildContext context) =>
      locator<MyPageViewModel>();
}
