import 'package:uppercut_fantube/utilities/index.dart';

class ContentDetailScreen extends BaseScreen<ContentDetailViewModel> {
  const ContentDetailScreen({Key? key}) : super(key: key);

  @override
  Widget buildScreen(BuildContext context) {
    return ContentDetailScaffold(
      header: _buildHeader(),
      headerBackdropImgUrl: vm.headerBackdropImg,
      rateAndGenreView: _buildRateAndGenreView(),
      tabs: _buildTab(),
      tabViews: _buildTabBarViews(),
    );
  }

  // 탭뷰
  List<Widget> _buildTabBarViews() => [
        const MainContentTabView(),
        const ContentInfoTabView(),
      ];

  // 평점 & 장르 뷰
  Widget _buildRateAndGenreView() => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            'RATE',
            style: AppTextStyle.extraFont.copyWith(
              color: const Color(0xFFE6E6E6).withOpacity(0.66),
            ),
          ),
          Obx(
            () => Text(
              vm.rate ?? '-',
              style: AppTextStyle.alert2.copyWith(
                color: const Color(0xFFA8A8A8).withOpacity(0.40),
              ),
            ),
          ),
          AppSpace.size4,
          Text(
            'GENRE',
            style: AppTextStyle.extraFont.copyWith(
              color: const Color(0xFFE6E6E6).withOpacity(0.66),
            ),
          ),
          Obx(
            () => Text(
              vm.genre ?? '-',
              style: AppTextStyle.alert2.copyWith(
                color: const Color(0xFFA8A8A8).withOpacity(0.40),
              ),
            ),
          )
        ],
      );

  // 헤더 섹션
  Widget _buildHeader() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 480,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            // 제목 & 날짜
            Row(
              children: <Widget>[
                Obx(
                  () => vm.headerTitle.hasData
                      ? Text(vm.headerTitle!.value,
                          style: AppTextStyle.headline2)
                      : Shimmer(
                          color: AppColor.lightGrey,
                          child: const SizedBox(
                            height: 28,
                            width: 40,
                          ),
                        ),
                ),
                AppSpace.size6,
                Obx(
                  () => Text(
                    vm.releaseDate.hasData ? vm.releaseDate! : '-',
                    style: AppTextStyle.alert2,
                  ),
                )
              ],
            ),
            AppSpace.size8,
            // 컨텐츠 설명 - (유튜브 영상 제목)
            Obx(
              () => vm.headerContentDesc.hasData
                  ? Text(
                      vm.headerContentDesc!.value,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.headline3
                          .copyWith(color: AppColor.lightGrey),
                    )
                  : Column(
                      children: [
                        Shimmer(
                          color: AppColor.lightGrey,
                          child: const SizedBox(
                            height: 22,
                            width: double.infinity,
                          ),
                        ),
                      ],
                    ),
            ),

            AppSpace.size24,
          ],
        ),
      );

  // 탭바
  List<Tab> _buildTab() {
    return const [
      Tab(text: '컨텐츠', height: 42),
      Tab(text: '정보', height: 42),
    ];
  }

  @override
  bool get wrapWithSafeArea => false;

  @override
  bool get extendBodyBehindAppBar => false;

  // Sliver레이아웃에서 Tab이 고정되기 위해서 [Sizse.zero]인 Appbar가 필요
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.zero,
      child: AppBar(
        backgroundColor: Colors.black,
      ),
    );
  }
}
