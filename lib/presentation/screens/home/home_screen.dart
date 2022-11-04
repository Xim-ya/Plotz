import 'dart:ui';

import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:uppercut_fantube/app/config/font_config.dart';
import 'package:uppercut_fantube/presentation/screens/home/home_view_model.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class HomeScreen extends BaseScreen<HomeViewModel> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  bool get wrapWithSafeArea => false;

  @override
  Widget buildScreen(BuildContext context) {
    return PreferredSize(
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: vm.scrollController,
              child: Container(
                height: 10000,
                width: double.infinity,
                color: Colors.blue,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Center(child: Text('$index'));
                  },
                ),
              ),
            ),
            Obx(() => AnimatedOpacity(
                  opacity: vm.showBlurAtAppBar.value ? 1 : 0,
                  duration: Duration(milliseconds : 300),
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        height: 100,
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                )),
            Container(
              color: Colors.transparent,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    'assets/images/main_logo.png',
                    height: 40,
                    width: 40,
                  )
                ],
              ),
            ),

          ],
        ),
        preferredSize: Size(10, 90));
  }
}
