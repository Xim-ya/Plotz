import 'package:uppercut_fantube/presentation/screens/contentDetail/content_detail_scaffold.dart';
import 'package:uppercut_fantube/presentation/screens/contentDetail/content_detail_view_model.dart';
import 'package:uppercut_fantube/presentation/screens/contentDetail/localWidget/tab/content_info_tab_view.dart';
import 'package:uppercut_fantube/presentation/screens/contentDetail/localWidget/tab/single_episode_content_tab_view.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class ContentDetailScreen extends BaseScreen<ContentDetailViewModel> {
  const ContentDetailScreen({Key? key}) : super(key: key);

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

  @override
  Widget buildScreen(BuildContext context) {
    return ContentDetailScaffold(
      header: _buildHeader(),
      rateAndGenreView: _buildRateAndGenreView(),
      tabs: _buildTab(),
      tabBarViews: _buildTabBarViews(),
    );
  }

  // 탭뷰
  List<Widget> _buildTabBarViews() => [
        const SingleEpisodeContentTabView(),
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
          Text(
            '7.2',
            style: AppTextStyle.alert2.copyWith(
              color: Color(0xFFA8A8A8).withOpacity(0.40),
            ),
          ),
          AppSpace.size4,
          Text(
            'GENRE',
            style: AppTextStyle.extraFont.copyWith(
              color: const Color(0xFFE6E6E6).withOpacity(0.66),
            ),
          ),
          Text(
            '드라마 / 로맨스 / 액션',
            style: AppTextStyle.alert2.copyWith(
              color: const Color(0xFFA8A8A8).withOpacity(0.40),
            ),
          ),
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
            // OTT 서비스 인디케이터
            FittedBox(
              child: Container(
                height: 26,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/netflix_logo.png',
                      width: 18,
                      height: 18,
                    ),
                    AppSpace.size4,
                    Text('Netflix', style: AppTextStyle.alert1),
                  ],
                ),
              ),
            ),
            AppSpace.size4,
            // 제목 & 날짜
            Row(
              children: <Widget>[
                Text('올드맨', style: AppTextStyle.headline2),
                AppSpace.size6,
                Text(
                  '2022.10.15',
                  style: AppTextStyle.alert2,
                ),
              ],
            ),
            AppSpace.size8,
            // 컨텐츠 설명 - (영상 제목)
            Text(
              '하필이면 전직 특수 요원을 건드렸는데 개들이 싸움을 더 잘함 | 2022년 신작 중 가장 처절한 싸이 시작됩니다',
              style: AppTextStyle.headline3.copyWith(color: AppColor.lightGrey),
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
}
