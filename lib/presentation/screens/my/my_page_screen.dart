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
                  vm.signOut(Sns.google);
                },
              ),
            ),
          ),
          AppSpace.size16,

          // 프로필
          GestureDetector(
            onTap: () {
              vm.fetchUserCurationSummary();
            },
            child: Padding(
              padding: AppInset.horizontal16,
              child: Row(
                children: <Widget>[
                  GetBuilder<MyPageViewModel>(
                    builder:(_) => RoundProfileImg(
                      size: 58,
                      imgUrl: vm.userInfo?.photoUrl,
                    ),
                  ),
                  AppSpace.size10,
                  GetBuilder<MyPageViewModel>(
                    builder: (_) => Text(
                      '${vm.displayName ?? '-'}님',
                      style: AppTextStyle.title1
                          .copyWith(color: AppColor.mixedWhite),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AppSpace.size34,

          // 큐레이션
          Padding(
            padding: AppInset.horizontal16,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: vm.routeToCurationHistory,
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
            onTap: vm.routeToCurationHistory,
            child: Container(
                margin: AppInset.horizontal16,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColor.strongGrey,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: GetBuilder<MyPageViewModel>(
                  builder:(_)  =>Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _curationProgressRowItem(
                          title: '진행중',
                          count: vm.curationSummary?.inProgressCount ?? 0),
                      Container(
                        height: 24,
                        width: 1,
                        color: AppColor.lightGrey,
                      ),
                      _curationProgressRowItem(
                          title: '등록 완료',
                          count: vm.curationSummary?.completedCount ?? 0),
                      Container(
                        height: 24,
                        width: 1,
                        color: AppColor.lightGrey,
                      ),
                      _curationProgressRowItem(
                          title: '보류',
                          count: vm.curationSummary?.onHoldCount ?? 0),
                    ],
                  ),
                )),
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
          ContentPostSlider(
            height: 168,
            itemCount: 12,
            itemBuilder: (BuildContext context, int index) {
              return const ContentPostItem(
                  ratio: 96 / 142, imgUrl: '/f2PVrphK0u81ES256lw3oAZuF3x.jpg');
            },
          ),
          AppSpace.size48,
        ],
      ),
    );
  }

  Widget _curationProgressRowItem({required String title, required int count}) {
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
}
