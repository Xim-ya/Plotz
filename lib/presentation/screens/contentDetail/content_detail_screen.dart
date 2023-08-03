import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/presentation/index.dart';
import 'package:soon_sak/utilities/index.dart';
import 'package:tuple/tuple.dart';

class ContentDetailScreen extends BaseView<ContentDetailViewModel> {
  const ContentDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContentDetailScaffold(
      appBar: const _AppBar(),
      header: const _HeaderBgImg(),
      rateAndGenreView: Container(),
      tabs: _buildTab(),
      tabViews: _buildTabBarViews(),
      headerDescription: const _HeaderDescription(),
      playBtn: const _PlayBtn(),
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
}

class _PlayBtn extends BaseView<ContentDetailViewModel> {
  const _PlayBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<ContentDetailViewModel, ContentVideoModel?>(
      selector: (_, vm) => vm.videoInfo,
      child: const SizedBox(
        height: 40,
        width: 40,
        child: CircularProgressIndicator(
          strokeWidth: 2.6,
          color: AppColor.gray05,
        ),
      ),
      builder: (context, videoInfo, loadingView) {
        return videoInfo.hasData
            ? Stack(
                children: [
                  Positioned(
                    child: Center(
                      child: GestureDetector(
                        onTap: vm(context).goToContent,
                        child: Container(
                          color: Colors.transparent,
                          height: 120,
                          width: 120,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      minWidth: 0,
                      padding: EdgeInsets.zero,
                      onPressed: vm(context).goToContent,
                      child: SvgPicture.asset('assets/icons/play.svg'),
                    ),
                  ),
                ],
              )
            : loadingView!;
      },
    );
  }
}

// 헤더 콘텐츠 설명
class _HeaderDescription extends BaseView<ContentDetailViewModel> {
  const _HeaderDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 156,
      padding: AppInset.top10,
      color: AppColor.black,
      child: Column(
        children: <Widget>[
          Selector<
              ContentDetailViewModel,
              Tuple6<String, String?, String?, String?, ContentVideoModel?,
                  String?>>(
            selector: (_, vm) => Tuple6(
              vm.contentTypeToString,
              vm.headerTitle,
              vm.releaseYear,
              vm.genre,
              vm.videoInfo,
              vm.contentVideoTitle,
            ),
            builder: (context, value, _) {
              return Column(
                children: <Widget>[
                  AppSpace.size8,
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
                      style: AppTextStyle.headline1,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),

                  // 개봉년도 & 장르
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: value.item3.hasData ? '${value.item3} · ' : '',
                          style: AppTextStyle.alert2
                              .copyWith(color: AppColor.gray02),
                        ),
                        TextSpan(
                          text: value.item4,
                          style: AppTextStyle.alert2
                              .copyWith(color: AppColor.gray02),
                        ),
                      ],
                    ),
                  ),
                  AppSpace.size16,

                  // 영상제목
                  SizedBox(
                    width: SizeConfig.to.screenWidth - 96,
                    child: value.item5?.youtubeInfoLoaded ?? false
                        ? Text(
                            value.item6 ?? '제목 없음',
                            textAlign: TextAlign.center,
                            style: AppTextStyle.body3,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          )
                        : StreamBuilder<YoutubeVideoContentInfo?>(
                            stream: value.item5?.videos[0].youtubeInfo,
                            builder: (context, snapshot) {  
                              return Text(
                                snapshot.hasData
                                    ? snapshot.data!.videoTitle
                                    : vm(context).passedArgument.videoTitle ??
                                        '-',
                                textAlign: TextAlign.center,
                                style: AppTextStyle.body3,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              );
                            },
                          ),
                  ),
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
          Tuple3(vm.hideAppBarColor, vm.videoInfo, vm.selectedEpisode),
      builder: (context, value, _) {
        return Stack(
          children: [
            // 헤더 포스터 상단 Gradient
            Positioned(
              child: Container(
                decoration:
                    const BoxDecoration(gradient: AppGradient.topToBottom),
              ),
            ),

            AnimatedContainer(
              duration: const Duration(microseconds: 50),
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
            ? AspectRatio(
                aspectRatio: 375 / 500,
                child: CachedNetworkImage(
                  alignment: Alignment.topCenter,
                  fadeInDuration: const Duration(milliseconds: 400),
                  memCacheWidth:
                      SizeConfig.to.screenWidth.cacheSize(context) * 375 ~/ 500,
                  fit: BoxFit.fitWidth,
                  width: SizeConfig.to.screenWidth,
                  imageUrl: headerBackdropImg!.prefixTmdbImgPath,
                  placeholder: (_, __) => const SizedBox(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              )
            : const SizedBox();
      },
    );
  }
}
