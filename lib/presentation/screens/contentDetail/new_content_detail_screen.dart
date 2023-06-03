import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:soon_sak/app/config/gradient_config.dart';
import 'package:soon_sak/domain/model/video/content_video_model.dart';
import 'package:soon_sak/presentation/base/base_view.dart';
import 'package:soon_sak/presentation/screens/contentDetail/localWidget/tabView/content_info_tab_view.dart';
import 'package:soon_sak/presentation/screens/contentDetail/localWidget/tabView/origin_content_info_tab_view.dart';
import 'package:soon_sak/presentation/screens/contentDetail/new_content_detail_scaffold.dart';
import 'package:soon_sak/utilities/index.dart';
import 'package:tuple/tuple.dart';

class NewContentDetailScreen extends BaseView<ContentDetailViewModel> {
  const NewContentDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NewContentDetailScaffold(
      appBar: const _AppBar(),
      header: const _HeaderBgImg(),
      rateAndGenreView: Container(),
      tabs: _buildTab(),
      tabViews: _buildTabBarViews(),
      headerDescription: const _HeaderDescription(),
    );
  }

  // 탭뷰
  List<Widget> _buildTabBarViews() => [
        const ContentInfoTabView(),
        const OriginContentInfoTabView(),
      ];

  // 탭바
  List<Tab> _buildTab() {
    return [
      const Tab(
        text: '콘텐츠 정보',
        height: 48,
      ),
      const Tab(text: '원작 정보', height: 48),
    ];
  }

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

// 헤더 콘텐츠 설명
class _HeaderDescription extends BaseView<ContentDetailViewModel> {
  const _HeaderDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppInset.top10,
      height: 140,
      color: AppColor.black,
      child: Column(
        children: <Widget>[
          Selector<
              ContentDetailViewModel,
              Tuple5<String, String?, String?, String?,
                  ValueStream<YoutubeVideoContentInfo?>?>>(
            selector: (_, vm) => Tuple5(
                vm.contentTypeToString,
                vm.headerTitle,
                vm.releaseYear,
                vm.genre,
                vm.videoInfo?.videos[0].youtubeInfo.stream),
            builder: (context, value, _) {
              return Column(
                children: <Widget>[
                  //콘텐츠 타입 인디케이터
                  FittedBox(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      height: 16,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4)),
                      child: Center(
                        child: Text(
                          value.item1,
                          style:
                              AppTextStyle.nav.copyWith(color: AppColor.black),
                        ),
                      ),
                    ),
                  ),
                  AppSpace.size6,

                  // 제목
                  SizedBox(
                    width: SizeConfig.to.screenWidth - 96,
                    child: Text(
                      value.item2 ?? '',
                      textAlign: TextAlign.center,
                      style: AppTextStyle.headline1
                          .copyWith(color: AppColor.green),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),

                  // 개봉년도 & 장르
                  RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: value.item3.hasData ? '${value.item3}·' : '',
                        style: AppTextStyle.alert2
                            .copyWith(color: AppColor.gray03),
                      ),
                      TextSpan(
                        text: value.item4,
                        style: AppTextStyle.alert2
                            .copyWith(color: AppColor.gray03),
                      ),
                    ]),
                  ),
                  AppSpace.size16,

                  // 영상제목
                  SizedBox(
                      width: SizeConfig.to.screenWidth - 96,
                      child: StreamBuilder<YoutubeVideoContentInfo?>(
                        stream: value.item5,
                        builder: (context, snapshot) {
                          return Text(
                            snapshot.hasData ? snapshot.data!.videoTitle : '',
                            textAlign: TextAlign.center,
                            style: AppTextStyle.body3,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          );
                        },
                      )),
                ],
              );
            },
          ),

          // 개봉년도 & 장르

          // 제목 (영상제목)
        ],
      ),
    );
  }
}

// 앱바
class _AppBar extends BaseView<ContentDetailViewModel> {
  const _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<ContentDetailViewModel,
        Tuple3<bool, ContentVideoModel?, int>>(
      selector: (context, vm) =>
          Tuple3(vm.showBackBtnOnTop, vm.videoInfo, vm.selectedEpisode),
      builder: (context, value, _) {
        return Stack(
          children: [
            // 헤더 포스터 상단 Gradient
            Positioned(
              child: Container(
                decoration: const BoxDecoration(
                    gradient: AppGradient.singleTopToBottom),
              ),
            ),

            AnimatedContainer(
              duration: const Duration(milliseconds: 120),
              padding: EdgeInsets.only(top: SizeConfig.to.statusBarHeight),
              height: 48 + SizeConfig.to.statusBarHeight,
              color: value.item1 ? Colors.transparent : AppColor.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  MaterialButton(
                    onPressed: context.pop,
                    minWidth: 0,
                    child: SvgPicture.asset(
                      'assets/icons/left_arrow.svg',
                      height: 24,
                      width: 24,
                    ),
                  ),
                  if (value.item2.hasData)
                    Builder(
                      builder: (context) {
                        final videoInfo = value.item2;
                        switch (videoInfo?.videoFormat) {
                          case null:
                            return const SizedBox();

                          case ContentVideoFormat.singleMovie:
                            return const SizedBox();

                          case ContentVideoFormat.multipleMovie:
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: MaterialButton(
                                minWidth: 0,
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  vm(context).showEpisodeSelectSheet();
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 6),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        '${value.item3}부',
                                        style: AppTextStyle.title2,
                                      ),
                                      AppSpace.size4,
                                      SvgPicture.asset(
                                        'assets/icons/drop_down.svg',
                                        height: 24,
                                        width: 24,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          case ContentVideoFormat.singleTv:
                            return const SizedBox();
                          case ContentVideoFormat.multipleTv:
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: MaterialButton(
                                minWidth: 0,
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  vm(context).showEpisodeSelectSheet();
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 6),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        '시즌 ${value.item3}',
                                        style: AppTextStyle.title2,
                                      ),
                                      AppSpace.size4,
                                      SvgPicture.asset(
                                        'assets/icons/drop_down.svg',
                                        height: 24,
                                        width: 24,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                        }
                      },
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

// 해더 백그라운드 이미지
class _HeaderBgImg extends BaseView<ContentDetailViewModel> {
  const _HeaderBgImg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<ContentDetailViewModel, String?>(
      selector: (context, vm) => vm.headerBackdropImg,
      builder: (context, headerBackdropImg, _) {
        return headerBackdropImg.hasData
            ? CachedNetworkImage(
                memCacheWidth: (SizeConfig.to.screenWidth * 3).toInt(),
                fit: BoxFit.fitHeight,
                height: SizeConfig.to.screenHeight * (375 / 500),
                imageUrl: vmS<String>(
                  context,
                  (vm) => headerBackdropImg!.prefixTmdbImgPath,
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              )
            : const SizedBox();
      },
    );
  }
}
