import 'package:uppercut_fantube/presentation/screens/search/localWidget/search_scaffold_controller.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class SearchScaffold extends BaseView<SearchScaffoldController> {
  const SearchScaffold({Key? key}) : super(key: key);

  @override
  Widget buildView(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFF1B1C1E)),
              ),
              color: AppColor.black,
            ),
            child: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: const Color(0xFF505153),
              indicatorColor: Colors.white,
              labelStyle: AppTextStyle.title3,
              unselectedLabelStyle: AppTextStyle.body2,
              onTap: (int) {},
              controller: vm.tabController,
              tabs: const [
                Tab(text: '컨텐츠', height: 42),
                Tab(text: '정보', height: 42),
              ],
            ),
          ),
          Text('aim', style: AppTextStyle.title1,),
          Expanded(
            child: TabBarView(controller: vm.tabController, children: [
              Container(
                child: ListView.builder(itemBuilder: (context, index) {
                  return Text(
                    '${index}Test',
                    style: AppTextStyle.headline1,
                  );
                }),
              ),
              Container(),
            ]),
          )
        ],
      ),
    );
  }
}
