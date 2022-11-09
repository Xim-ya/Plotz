import 'package:uppercut_fantube/presentation/screens/contentDetail/content_detail_scaffold.dart';
import 'package:uppercut_fantube/presentation/screens/contentDetail/content_detail_view_model.dart';
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
      rateAndGenreView:_buildRateAndGenreView(),
      tabs: _buildTab(),
      tabBarViews: _buildTabBarViews(),

    );
  }


  // 평점 & 장르 뷰
  Widget _buildRateAndGenreView() =>
      Positioned(
        top: 236,
        right: 16,
        // top: 188,
        child: Column(
          children: <Widget>[
            Column(
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
                    color: const Color(0xFFE6E6E6).withOpacity(0.66),),
                ),

                Text('드라마 / 로맨스 / 액션',
                  style: AppTextStyle.alert2
                      .copyWith(
                    color: const Color(0xFFA8A8A8).withOpacity(0.40),),),
              ],
            ),
          ],
        ),);

  // 헤더 섹션
  Widget _buildHeader() =>
      SizedBox(
        height: 480,

      );

  // 탭뷰
  List<Widget> _buildTabBarViews() =>
      [
        Container(
            height: 1000,
            color: AppColor.black,
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 100,
                itemBuilder: (context, index) =>
                    Center(
                        child: Text(
                          '${index}',
                          style: AppTextStyle.headline2,
                        )))),
        Container(
          child: Text('second tab view'),
        ),
        Container(
          child: Text('thrid tab view'),
        ),
      ];

  // 탭바
  List<Tab> _buildTab() {
    return const [
      Tab(text: '컨텐츠', height: 42),
      Tab(text: '정보', height: 42),
      Tab(text: '관련 콘텐츠', height: 42),
    ];
  }
}
