import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/presentation/index.dart';
import 'package:soon_sak/utilities/index.dart';

class MyPageScreen extends BaseScreen<MyPageViewModel> {
  const MyPageScreen({Key? key}) : super(key: key);

  @override
  Widget buildScreen(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          controller: vm(context).scrollController,
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
                          onTap: vm(context).routeToProfileSetting,
                          child: RoundProfileImg(
                            size: 90,
                            imgUrl: snapshot.data?.photoUrl,
                          ),
                        ),
                        AppSpace.size14,
                        Transform.translate(
                          offset: const Offset(10, 0),
                          child: TextButton(
                            onPressed: vm(context).routeToProfileSetting,
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
                      ? Container(
                          alignment: Alignment.center,
                          height: 160,
                          child: Text(
                            '앗! 아직 시청기록이 없으시네요.\n플로츠에서 다양한 콘텐츠를 즐겨보세요!',
                            style: AppTextStyle.body3
                                .copyWith(color: AppColor.gray03),
                            textAlign: TextAlign.center,
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

              // 환경설정
              Padding(
                padding: AppInset.left16,
                child: Text(
                  '환경 설정',
                  style: AppTextStyle.title2,
                ),
              ),
              _versionMenu(context),
              ...vm(context)
                  .settingOptions
                  .map(
                    (e) => _settingMenu(
                      title: e.name,
                      onTap: () {
                        vm(context).onSettingMenuTapped(e);
                      },
                    ),
                  )
                  .toList(),
              AppSpace.size56,
            ],
          ),
        ),
        Positioned(
          top: 0,
          child: Selector<MyPageViewModel, bool>(
            selector: (_, vm) => vm.hideGradient,
            builder: (_, hideGradient, __) => AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: hideGradient ? 0 : 1,
              child: Container(
                height: 88,
                width: SizeConfig.to.screenWidth,
                decoration: const BoxDecoration(
                  gradient: AppGradient.topToBottom,
                ),
              ),
            ),
          ),
        ),
      ],
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
        margin: AppInset.vertical14 + AppInset.horizontal16,
        height: 20,
        child: Text(
          title,
          style: AppTextStyle.body3.copyWith(
            color: AppColor.gray01,
          ),
        ),
      ),
    );
  }

  Container _versionMenu(BuildContext context) {
    return Container(
      margin:
          AppInset.horizontal16 + const EdgeInsets.only(top: 24, bottom: 16),
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: '현재 버전  ',
              style: AppTextStyle.body3.copyWith(
                color: AppColor.gray01,
              ),
            ),
            TextSpan(
              text: vm(context).currentVersionNum,
              style: AppTextStyle.body3.copyWith(
                color: AppColor.gray01,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
