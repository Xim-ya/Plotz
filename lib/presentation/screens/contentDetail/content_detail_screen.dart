import 'package:uppercut_fantube/presentation/screens/contentDetail/content_detail_scaffold.dart';
import 'package:uppercut_fantube/presentation/screens/contentDetail/content_detail_view_model.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class ContentDetailScreen extends BaseScreen<ContentDetailViewModel> {
  const ContentDetailScreen({Key? key}) : super(key: key);

  @override
  bool get wrapWithSafeArea => false;

  @override
  bool get extendBodyBehindAppBar => true;

  // @override
  // PreferredSizeWidget? buildAppBar(BuildContext context) {
  //   return AppBar(
  //     title: Text('aim'),
  //     backgroundColor: Colors.transparent,
  //   );
  // }

  @override
  Widget buildScreen(BuildContext context) {
    return ContentDetailScaffold(
      appBarLeading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {},
      ),
      header: _buildHeader(),
      tabs: _buildTab(),
      tabBarViews: _buildTabBarViews(),
    );
  }

  // 헤더 섹션
  Widget _buildHeader() => Stack(
          children: <Widget>[
            Container(height: 420,),
        ],
      );

  // 탭뷰
  List<Widget> _buildTabBarViews() => [
        Container(
          height: 1000,
          color: AppColor.black,
          child: ListView.builder(
            physics:const NeverScrollableScrollPhysics(),
              itemCount: 100,
              itemBuilder: (context, index) => Center(child: Text('${index}', style: AppTextStyle.headline2,)))
        ),
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
