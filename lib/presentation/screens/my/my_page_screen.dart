import 'package:provider/provider.dart';
import 'package:soon_sak/utilities/index.dart';
import 'dart:math' as math;

class MyPageScreen extends BaseScreen<MyPageViewModel> {
  const MyPageScreen({Key? key}) : super(key: key);

  @override
  Widget buildScreen(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // 설정 버튼
          Padding(
            padding: AppInset.right8,
            child: Align(
              alignment: Alignment.centerRight,
              child: IconInkWellButton.packageIcon(
                icon: Icons.settings,
                size: 24,
                onIconTapped: () {
                  vm(context).routeToSetting(context);
                },
              ),
            ),
          ),
          AppSpace.size16,

          // 프로필
          Padding(
            padding: AppInset.horizontal16,
            child: StreamBuilder<UserModel>(
              stream: vm(context).userInfoSub.stream,
              builder: (context, snapshot) {
                return Row(
                  children: <Widget>[
                    RoundProfileImg(
                      size: 58,
                      imgUrl: snapshot.data?.photoUrl,
                    ),
                    AppSpace.size10,
                    Text(
                      '${snapshot.data?.displayName ?? '-'}님',
                      style: AppTextStyle.title1
                          .copyWith(color: AppColor.mixedWhite),
                    ),
                  ],
                );
              },
            ),
          ),
          AppSpace.size34,

          // 큐레이션
          Padding(
            padding: AppInset.horizontal16,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                vm(context).routeToCurationHistory(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '큐레이션 내역',
                    style: AppTextStyle.headline2,
                  ),
                  Transform.rotate(
                    angle: 180 * math.pi / 180,
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: AppColor.mixedWhite,
                      size: 18,
                    ),
                  )
                ],
              ),
            ),
          ),
          AppSpace.size14,
          GestureDetector(
            onTap: () {
              vm(context).routeToCurationHistory(context);
            },
            child: Container(
              margin: AppInset.horizontal16,
              height: 80,
              decoration: BoxDecoration(
                color: AppColor.strongGrey,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Selector<MyPageViewModel, UserCurationSummary?>(
                selector: (context, vm) => vm.curationSummary,
                builder: (context, curationSummary, _) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _curationProgressRowItem(
                        title: '진행중',
                        count: curationSummary?.inProgressCount ?? 0,
                      ),
                      Container(
                        height: 24,
                        width: 1,
                        color: AppColor.lightGrey,
                      ),
                      _curationProgressRowItem(
                        title: '등록 완료',
                        count: curationSummary?.completedCount ?? 0,
                      ),
                      Container(
                        height: 24,
                        width: 1,
                        color: AppColor.lightGrey,
                      ),
                      _curationProgressRowItem(
                        title: '보류',
                        count: curationSummary?.onHoldCount ?? 0,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),

          AppSpace.size64,

          // 시청 기록
          Padding(
            padding: AppInset.left16,
            child: Text(
              '시청 기록',
              style: AppTextStyle.headline2,
            ),
          ),
          AppSpace.size14,

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
                      height: 168,
                      itemCount: items?.length ?? 5,
                      itemBuilder: (BuildContext context, int index) {
                        final item = items?[index];
                        return ImageViewWithPlayBtn(
                          aspectRatio: 1280 / 1920,
                          onPlayerBtnClicked: () {
                            if (item == null) return;
                            vm(context).launchYoutubeApp(item, index);
                          },
                          posterImgUrl: item?.posterImgUrl != null
                              ? item!.posterImgUrl!.prefixTmdbImgPath
                              : null,
                        );
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
