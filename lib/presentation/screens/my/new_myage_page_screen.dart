import 'package:soon_sak/presentation/common/image/content_poster_item_view.dart';
import 'package:soon_sak/utilities/index.dart';

class NewMyPageScreen extends BaseScreen<MyPageViewModel> {
  const NewMyPageScreen({Key? key}) : super(key: key);

  @override
  Widget buildScreen(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 60),
          // 상단 프로필 이미지
          StreamBuilder<UserModel>(
            stream: vm(context).userInfoSub.stream,
            builder: (context, snapshot) {
              return Center(
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap:(){},
                      child: RoundProfileImg(
                        size: 90,
                        imgUrl: snapshot.data?.photoUrl,
                      ),
                    ),
                    AppSpace.size14,
                    Transform.translate(
                      offset: const Offset(10, 0),
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: const EdgeInsets.only(
                            right: 24,
                            left: 4,
                          ),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Text(
                              snapshot.data?.displayName ?? '-',
                              style: AppTextStyle.headline1.copyWith(
                                color: AppColor.mixedWhite,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              bottom: 0,
                              right: -22,
                              child: SvgPicture.asset(
                                'assets/icons/edit.svg',
                                width: 20,
                                height: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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
                style: AppTextStyle.title2,
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
                            title: item!.title,
                          );
                        } else {
                          return ContentPosterItemView.createSkeleton();
                        }
                      },
                    );
            },
          ),
          AppSpace.size56,
          Padding(
            padding: AppInset.left16,
            child: Text(
              '환경 설정',
              style: AppTextStyle.title2,
            ),
          ),
          _versionMenu(context),
          _settingMenu(
              title: '프로필 설정', onTap: vm(context).routeToProfileSetting),
          _settingMenu(title: '로그아웃', onTap: vm(context).signOut),
          _settingMenu(title: '개인정보 및 약관', onTap: vm(context).routeToTerms),
          _settingMenu(
              title: '피드백 및 문의사항', onTap: vm(context).goToKakaoOneonOne),
          _settingMenu(title: '회원탈퇴', onTap: vm(context).showWithdrawnInoModal),
        ],
      ),
    );
  }

  @override
  MyPageViewModel createViewModel(BuildContext context) =>
      locator<MyPageViewModel>();

  InkWell _settingMenu({required String title, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: AppInset.all16,
        height: 20,
        child: Text(
          title,
          style: AppTextStyle.title2.copyWith(fontFamily: 'pretendard_regular'),
        ),
      ),
    );
  }

  Container _versionMenu(BuildContext context) {
    return Container(
      margin: AppInset.all16,
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: '현재 버전  ',
              style: AppTextStyle.title2
                  .copyWith(fontFamily: 'pretendard_regular'),
            ),
            TextSpan(
              text: vm(context).currentVersionNum,
              style: AppTextStyle.title2.copyWith(
                fontFamily: 'pretendard_regular',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
