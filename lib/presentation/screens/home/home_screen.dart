import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:uppercut_fantube/app/config/app_space_config.dart';
import 'package:uppercut_fantube/app/config/size_config.dart';
import 'package:uppercut_fantube/presentation/common/icon_ink_well_button.dart';
import 'package:uppercut_fantube/presentation/screens/home/home_scaffold.dart';
import 'package:uppercut_fantube/presentation/screens/home/home_view_model.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class HomeScreen extends BaseScreen<HomeViewModel> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  bool get wrapWithSafeArea => false;

  @override
  Widget buildScreen(BuildContext context) {
    return HomeScaffold(
      scrollController: vm.scrollController,
      animationAppbar: _buildAnimationAppbar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        Stack(
          children: <Widget>[
            /* Gradient Poster Background 섹션 */
            // 포스터 이미지
            CachedNetworkImage(
              width: double.infinity,
              fit: BoxFit.fitWidth,
              imageUrl:
                  'https://image.tmdb.org/t/p/w1280/euYz4adiSHH0GE3YnTeh3uLfBvL.jpg',
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            // Graident 레이어
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black, Colors.transparent, AppColor.black],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: <double>[0.0, 0.5, 1.0],
                  ),
                ),
              ),
            ),
            /* 컨텐츠 섹션 */
            Column(
              children: [
                SizedBox(height: vm.appBarHeight), // 커스텀 앱바와 간격을 맞추기 위한 위젯
                AppSpace.size72,
                CarouselSlider.builder(
                  itemCount: 15,
                  itemBuilder:
                      (BuildContext context, int itemIndex, int pageViewIndex) {
                    return Container(

                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      color: Colors.red,
                      width: double.infinity,
                      child: Text(itemIndex.toString()),
                    );
                  },
                  options: CarouselOptions(
                    viewportFraction: 0.93,
                    aspectRatio: 337 / 276


                  ),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }

  List<Widget> _buildAnimationAppbar() {
    return [
      Obx(
        () => AnimatedOpacity(
          opacity: vm.showBlurAtAppBar.value ? 1 : 0,
          duration: const Duration(milliseconds: 300),
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                height: vm.appBarHeight,
                color: Colors.transparent,
              ),
            ),
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: SizeConfig.to.statusBarHeight) +
            const EdgeInsets.symmetric(horizontal: 16),
        color: Colors.transparent,
        height: vm.appBarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.asset(
              'assets/images/main_logo.png',
              height: 40,
              width: 40,
            ),
            IconInkWellButton(
                iconPath: 'assets/icons/search.svg',
                iconSize: 40,
                onIconTapped: () {})
          ],
        ),
      )
    ];
  }
}
