import 'package:provider/provider.dart';
import 'package:soon_sak/presentation/base/new_base_view.dart';
import 'package:soon_sak/presentation/common/skeleton_box.dart';
import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2022.1.1
 * 비디오 컨텐츠 정보를 담고 있는 위젯
 * [ContentVideoFormat]에 따라 분기되는 위젯이 달라짐
 * - 단일 비디오 컨텐츠 (영화)
 * - 여러 회차로 나누어져 있는 비디오 컨텐츠 (영화)
 * - 단일 비디오 컨텐츠 (TV)
 * - 여러 시즌으로 구성되어 있는 비디오 컨텐츠 (TV)
 * */

class ContentVideoViewsByCase extends NewBaseView<ContentDetailViewModel> {
  const ContentVideoViewsByCase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (vmS(context, (vm) => vm.contentVideoFormat)) {
      case ContentVideoFormat.singleMovie:
        return _buildSingleMovieVideoView(context);
      case ContentVideoFormat.multipleMovie:
        return _buildMultipleMoviesVideoView(context);
      case ContentVideoFormat.singleTv:
        return _buildSingleTvVideoView(context);
      case ContentVideoFormat.multipleTv:
        return _buildMultipleTvVideoView(context);
      default:
        return const SizedBox();
    }
  }

  // 싱글 포맷 '영화' 비디오
  Widget _buildSingleMovieVideoView(BuildContext context) => Padding(
        padding: AppInset.horizontal16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SectionTitle(title: '콘텐츠'),
            ImageViewWithPlayBtn(
              onPlayerBtnClicked: () {
                vm(context).launchYoutubeApp(vm(context).singleVideoId);
              },
              posterImgUrl: vm(context).singleVideoThumbnailUrl,
            ),
            AppSpace.size4,
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Opacity(
                        opacity: 1,
                        child: Icon(
                          Icons.thumb_up,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      AppSpace.size4,
                      if (vm(context).singleLikesCount.hasData)
                        Text(
                          vm(context).singleLikesCount!,
                          style: AppTextStyle.body3,
                        )
                      else
                        const Padding(
                          padding: EdgeInsets.only(left: 2),
                          child: SkeletonBox(
                            height: 16,
                            width: 24,
                          ),
                        ),
                    ],
                  ),
                  if (vm(context).singleVideoViewCount.hasData &&
                      vm(context).singleUploadDate.hasData)
                    Text(
                      '조회수 ${vm(context).singleVideoViewCount} · ${vm(context).singleUploadDate}',
                      style: AppTextStyle.body3,
                    )
                  else
                    Row(
                      children: const <Widget>[
                        SkeletonBox(
                          height: 16,
                          width: 70,
                        ),
                        AppSpace.size6,
                        SkeletonBox(
                          height: 16,
                          width: 36,
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      );

  // 멀티플 포맷 '영화' 비디오
  Widget _buildMultipleMoviesVideoView(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: AppInset.horizontal16,
            child: SectionTitle(title: '콘텐츠'),
          ),
          CarouselSlider.builder(
            itemCount: vm(context).isVideoContentLoaded
                ? vm(context).multipleVideoInfo!.length
                : 0,
            options: CarouselOptions(
              aspectRatio: 16 / 9.6,
              enableInfiniteScroll: false,
              viewportFraction: 0.93,
            ),
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) {
              final videoInfoItem = vm(context).multipleVideoInfo![itemIndex];
              return SizedBox(
                width: SizeConfig.to.screenWidth - 32,
                // margin: AppInset.right8,
                child: Column(
                  children: <Widget>[
                    // 썸네일 이미지
                    ImageViewWithPlayBtn(
                      onPlayerBtnClicked: () {
                        vm(context).launchYoutubeApp(videoInfoItem.videoId);
                      },
                      posterImgUrl:
                          videoInfoItem.detailInfo?.videoThumbnailUrl ?? '',
                    ),
                    AppSpace.size4,
                    Container(
                      padding: AppInset.horizontal8,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              const Opacity(
                                opacity: 1,
                                child: Icon(
                                  Icons.thumb_up,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              ),
                              AppSpace.size4,
                              if (vm(context).multipleVideoInfo.hasData)
                                Text(
                                  videoInfoItem.detailInfo?.likeCount
                                          .toString() ??
                                      '',
                                  style: AppTextStyle.body3,
                                )
                              else
                                const Padding(
                                  padding: EdgeInsets.only(left: 2),
                                  child: SkeletonBox(
                                    height: 16,
                                    width: 20,
                                  ),
                                ),
                            ],
                          ),
                          if (vm(context).multipleVideoInfo.hasData)
                            Text(
                              '조회수 ${Formatter.formatNumberWithUnit(videoInfoItem.detailInfo?.viewCount, isViewCount: true)} · ${Formatter.getDateDifferenceFromNow(videoInfoItem.detailInfo!.uploadDate!)}',
                              style: AppTextStyle.body3,
                            )
                          else
                            Row(
                              children: const <Widget>[
                                SkeletonBox(
                                  height: 16,
                                  width: 70,
                                ),
                                AppSpace.size6,
                                SkeletonBox(
                                  height: 16,
                                  width: 36,
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      );

  // 싱글 포맷 'TV' 비디오
  Widget _buildSingleTvVideoView(BuildContext context) => Padding(
        padding: AppInset.horizontal16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SectionTitle(title: '콘텐츠'),
            ImageViewWithPlayBtn(
              onPlayerBtnClicked: () {
                vm(context).launchYoutubeApp(vm(context).singleVideoId);
              },
              posterImgUrl: vm(context).singleVideoThumbnailUrl,
            ),
            AppSpace.size4,
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Opacity(
                        opacity: 1,
                        child: Icon(
                          Icons.thumb_up,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      AppSpace.size4,
                      if (vm(context).singleLikesCount.hasData)
                        Text(
                          vm(context).singleLikesCount!,
                          style: AppTextStyle.body3,
                        )
                      else
                        const Padding(
                          padding: EdgeInsets.only(left: 2),
                          child: SkeletonBox(
                            height: 16,
                            width: 20,
                          ),
                        ),
                    ],
                  ),
                  if (vm(context).singleVideoViewCount.hasData &&
                      vm(context).singleUploadDate.hasData)
                    Text(
                      '조회수 ${vm(context).singleVideoViewCount} · ${vm(context).singleUploadDate}',
                      style: AppTextStyle.body3,
                    )
                  else
                    Row(
                      children: const <Widget>[
                        SkeletonBox(
                          height: 16,
                          width: 70,
                        ),
                        AppSpace.size6,
                        SkeletonBox(
                          height: 16,
                          width: 36,
                        )
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      );

  // 멀티플 포맷 'TV' 비디오
  Widget _buildMultipleTvVideoView(BuildContext context) => Padding(
        padding: AppInset.horizontal16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SectionTitle(title: '시즌 에피소드'),
            Selector<ContentDetailViewModel, ContentVideos?>(
              selector: (context, vm) => vm.contentVideos,
              builder: (context, videos, _) {
                if (videos?.multipleTypeVideos.isEmpty ?? true) {
                  // 데이터가 없는 경우에 대한 처리
                  return const Text('시즌 에피소드가 없습니다.');
                }

                return ListView.separated(
                  itemCount: videos!.multipleTypeVideos.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (_, __) => AppSpace.size16,
                  itemBuilder: (context, index) {
                    final episodeItem = videos.multipleTypeVideos[index];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '시즌 ${episodeItem.episodeNum}',
                          style: AppTextStyle.body1,
                        ),
                        AppSpace.size2,
                        StreamBuilder<SeasonInfo?>(
                          stream: episodeItem.tvSeasonInfoStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final seasonInfo = snapshot.data!;
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    width: vm(context).seasonEpisodeImgWidth,
                                    child: ImageViewWithPlayBtn(
                                      aspectRatio: 2 / 3,
                                      onPlayerBtnClicked: () {
                                        vm(context).launchYoutubeApp(
                                            episodeItem.videoId);
                                      },
                                      posterImgUrl: seasonInfo
                                          .posterPathUrl?.prefixTmdbImgPath,
                                    ),
                                  ),
                                  AppSpace.size10,
                                  Expanded(
                                    child: Text(
                                      seasonInfo.description != ''
                                          ? seasonInfo.description
                                          : '내용 없음',
                                      style: AppTextStyle.body3,
                                    ),
                                  ),
                                ],
                              );
                            } else if (snapshot.hasError) {
                              return const Text('비디오 상세 정보를 불러오는데 실패하였습니다.');
                            }
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                    width: vm(context).seasonEpisodeImgWidth,
                                    child: SkeletonBox(
                                      height:
                                          vm(context).seasonEpisodeImgWidth *
                                              3 /
                                              2,
                                      width: vm(context).seasonEpisodeImgWidth,
                                    )),
                                AppSpace.size10,
                                Expanded(
                                  child: Column(
                                    children: [
                                      SkeletonBox(
                                        height: 16,
                                        width: SizeConfig.to.screenWidth -
                                            vm(context).seasonEpisodeImgWidth -
                                            42,
                                      ),

                                      AppSpace.size2,


                                      SkeletonBox(
                                        height: 16,
                                        width: SizeConfig.to.screenWidth -
                                            vm(context).seasonEpisodeImgWidth -
                                            42,
                                      ),
                                      AppSpace.size2,
                                      SkeletonBox(
                                        height: 16,
                                        width: SizeConfig.to.screenWidth -
                                            vm(context).seasonEpisodeImgWidth -
                                            42,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      );
}
