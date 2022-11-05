import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
  import 'package:carousel_slider/carousel_slider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:uppercut_fantube/app/config/app_space_config.dart';
import 'package:uppercut_fantube/app/config/font_config.dart';
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
      stackedGradientPosterBg: _buildStackedGradientPosterBg(),
      contentSlider: _buildContentSlider(),
      body: _buildBody(),
      appBarHeight: vm.appBarHeight,
    );
  }

  Widget _buildContentSlider() => CarouselSlider.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
          /// Top Content Section
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '올드맨',
                  style: AppTextStyle.headline2,
                ),
                AppSpace.size2,
                Text(
                  '하필이면 전직 특수 요원을 건드렸는데 개들이 싸움을 더 잘함 | 2022년 신작 중 가장 처절한 액션을 보여드립니다',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: AppTextStyle.headline3
                      .copyWith(color: AppColor.lightGrey),
                ),
                AppSpace.size8,
                // 유튜브 썸네일 이미지
                Expanded(
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://i.ytimg.com/vi/TXMtLF5OANI/maxresdefault.jpg',
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Shimmer(
                            child: Container(
                              color: AppColor.black,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      // Play 아이콘
                      Center(
                          child: IconInkWellButton(
                              iconPath: 'assets/icons/play.svg',
                              iconSize: 54,
                              onIconTapped: () {}))
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        options: CarouselOptions(
            initialPage: 0,
            enableInfiniteScroll: false,
            viewportFraction: 0.93,
            aspectRatio: 337 / 276),
      );

  List<Widget> _buildStackedGradientPosterBg() => [
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
        )
      ];

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
                  itemCount: 3,
                  itemBuilder:
                      (BuildContext context, int itemIndex, int pageViewIndex) {
                    /// Top Content Section
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '올드맨',
                            style: AppTextStyle.headline2,
                          ),
                          AppSpace.size2,
                          Text(
                            '하필이면 전직 특수 요원을 건드렸는데 개들이 싸움을 더 잘함 | 2022년 신작 중 가장 처절한 액션을 보여드립니다',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: AppTextStyle.headline3
                                .copyWith(color: AppColor.lightGrey),
                          ),
                          AppSpace.size8,
                          // 유튜브 썸네일 이미지
                          Expanded(
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        'https://i.ytimg.com/vi/TXMtLF5OANI/maxresdefault.jpg',
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) => Shimmer(
                                      child: Container(
                                        color: AppColor.black,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                                // Play 아이콘
                                Center(
                                    child: IconInkWellButton(
                                        iconPath: 'assets/icons/play.svg',
                                        iconSize: 54,
                                        onIconTapped: () {}))
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  options: CarouselOptions(
                      initialPage: 0,
                      enableInfiniteScroll: false,
                      viewportFraction: 0.93,
                      aspectRatio: 337 / 276),
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
