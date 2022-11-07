import 'package:flutter_svg/flutter_svg.dart';
import 'package:uppercut_fantube/presentation/screens/contentDetail/content_detail_scaffold.dart';
import 'package:uppercut_fantube/presentation/screens/contentDetail/content_detail_view_model.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class ContentDetailScreen extends BaseScreen<ContentDetailViewModel> {
  const ContentDetailScreen({Key? key}) : super(key: key);

  @override
  bool get wrapWithSafeArea => false;

  @override
  Widget buildScreen(BuildContext context) {
    return ContentDetailScaffold(
      appBarLeading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () {  },),
      header: _buildHeader(),
      tabs: _buildTab(),
      tabBarViews: _buildTabBarViews(),
    );
  }


  // 헤더 섹션
  Widget _buildHeader()=> Container(
    height: 140,
    width: double.infinity,
    color: Colors.red,
  );


  // 탭뷰
  List<Widget> _buildTabBarViews() => [
    Container(
      height: 1000,
      child: Text('fisrt tab view'),
    ),
    Container(
      child: Text('fisrt tab view'),
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
