import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2022.1.1
 * 비디오 컨텐츠 정보를 담고 있는 위젯
 * [ContentVideoFormat]에 따라 분기되는 위젯이 달라짐
 * - 단일 비디오 컨텐츠 (영화)
 * - 여러 회차로 나누어져 있는 비디오 컨텐츠 (영화)
 * - 단일 비디오 컨텐츠 (TV)
 * - 여러 시즌으로 구성되어 있는 비디오 컨텐츠 (TV)
 * */

class ContentVideoViewsByCase extends BaseView<ContentDetailViewModel> {
  const ContentVideoViewsByCase({Key? key}) : super(key: key);

  @override
  Widget buildView(BuildContext context) {
    switch (vm.contentVideoFormat) {
      case ContentVideoFormat.singleMovie:
        return _buildSingleMovieVideoView();
      case ContentVideoFormat.multipleMovie:
        return _buildMultipleMoviesVideoView();
      case ContentVideoFormat.singleTv:
        return _buildSingleTvVideoView();
      case ContentVideoFormat.multipleTv:
        return _buildMultipleTvVideoView();
      default:
        return const SizedBox();
    }
  }

  // 싱글 포맷 '영화' 비디오
  Widget _buildSingleMovieVideoView() => Padding(
        padding: AppInset.horizontal16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SectionTitle(title: '콘텐츠'),
            ImageViewWithPlayBtn(
              onPlayerBtnClicked: () {
                vm.launchYoutubeApp(vm.singleVideoId);
              },
              posterImgUrl: vm.singleVideoThumbnailUrl,
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
                      if (vm.singleLikesCount.hasData)
                        Text(
                          vm.singleLikesCount!,
                          style: AppTextStyle.body3,
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.only(left: 2),
                          child: Shimmer(
                            color: AppColor.lightGrey,
                            child: const SizedBox(
                              height: 16,
                              width: 20,
                            ),
                          ),
                        ),
                    ],
                  ),
                  if (vm.singleVideoViewCount.hasData &&
                      vm.singleUploadDate.hasData)
                    Text(
                      '조회수 ${vm.singleVideoViewCount} · ${vm.singleUploadDate}',
                      style: AppTextStyle.body3,
                    )
                  else
                    Row(
                      children: <Widget>[
                        Shimmer(
                          child: Container(
                            color: AppColor.lightGrey.withOpacity(0.1),
                            height: 16,
                            width: 70,
                          ),
                        ),
                        AppSpace.size6,
                        Shimmer(
                          child: Container(
                            color: AppColor.strongGrey,
                            height: 16,
                            width: 36,
                          ),
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
  Widget _buildMultipleMoviesVideoView() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: AppInset.horizontal16,
            child: SectionTitle(title: '콘텐츠'),
          ),
          CarouselSlider.builder(
            itemCount:
                vm.isVideoContentLoaded ? vm.multipleVideoInfo!.length : 0,
            options: CarouselOptions(
              aspectRatio: 16 / 9.6,
              enableInfiniteScroll: false,
              viewportFraction: 0.93,
            ),
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) {
              final videoInfoItem = vm.multipleVideoInfo![itemIndex];
              return SizedBox(
                width: SizeConfig.to.screenWidth - 32,
                // margin: AppInset.right8,
                child: Column(
                  children: <Widget>[
                    // 썸네일 이미지
                    ImageViewWithPlayBtn(
                      onPlayerBtnClicked: () {
                        vm.launchYoutubeApp(videoInfoItem.videoId);
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
                              if (vm.multipleVideoInfo.hasData)
                                Text(
                                  videoInfoItem.detailInfo!.likeCount
                                      .toString(),
                                  style: AppTextStyle.body3,
                                )
                              else
                                Padding(
                                  padding: const EdgeInsets.only(left: 2),
                                  child: Shimmer(
                                    color: AppColor.lightGrey,
                                    child: const SizedBox(
                                      height: 16,
                                      width: 20,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          if (vm.multipleVideoInfo.hasData)
                            Text(
                              '조회수 ${Formatter.formatViewAndLikeCount(videoInfoItem.detailInfo?.viewCount, isViewCount: true)} · ${Formatter.getDateDifferenceFromNow(videoInfoItem.detailInfo!.uploadDate!)}',
                              style: AppTextStyle.body3,
                            )
                          else
                            Row(
                              children: <Widget>[
                                Shimmer(
                                  child: Container(
                                    color: AppColor.lightGrey.withOpacity(0.1),
                                    height: 16,
                                    width: 70,
                                  ),
                                ),
                                AppSpace.size6,
                                Shimmer(
                                  child: Container(
                                    color: AppColor.strongGrey,
                                    height: 16,
                                    width: 36,
                                  ),
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
  Widget _buildSingleTvVideoView() => Padding(
        padding: AppInset.horizontal16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SectionTitle(title: '콘텐츠'),
            ImageViewWithPlayBtn(
              onPlayerBtnClicked: () {
                vm.launchYoutubeApp(vm.singleVideoId);
              },
              posterImgUrl: vm.singleVideoThumbnailUrl,
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
                      if (vm.singleLikesCount.hasData)
                        Text(
                          vm.singleLikesCount!,
                          style: AppTextStyle.body3,
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.only(left: 2),
                          child: Shimmer(
                            color: AppColor.lightGrey,
                            child: const SizedBox(
                              height: 16,
                              width: 20,
                            ),
                          ),
                        ),
                    ],
                  ),
                  if (vm.singleVideoViewCount.hasData &&
                      vm.singleUploadDate.hasData)
                    Text(
                      '조회수 ${vm.singleVideoViewCount} · ${vm.singleUploadDate}',
                      style: AppTextStyle.body3,
                    )
                  else
                    Row(
                      children: <Widget>[
                        Shimmer(
                          child: Container(
                            color: AppColor.lightGrey.withOpacity(0.1),
                            height: 16,
                            width: 70,
                          ),
                        ),
                        AppSpace.size6,
                        Shimmer(
                          child: Container(
                            color: AppColor.strongGrey,
                            height: 16,
                            width: 36,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      );

  // 멀티플 포맷 'TV' 비디오
  Widget _buildMultipleTvVideoView() => Padding(
        padding: AppInset.horizontal16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SectionTitle(title: '시즌 에피소드'),
            ListView.separated(
              itemCount: vm.contentVideos.value?.multipleTypeVideos.length ?? 3,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final episodeItem =
                    vm.contentVideos.value!.multipleTypeVideos[index];
                return Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '시즌 ${episodeItem.episodeNum}',
                        style: AppTextStyle.body1,
                      ),
                      AppSpace.size2,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: vm.seasonEpisodeImgWidth,
                            child: ImageViewWithPlayBtn(
                              aspectRatio: 2 / 3,
                              onPlayerBtnClicked: () {
                                vm.launchYoutubeApp(episodeItem.videoId);
                              },
                              posterImgUrl: episodeItem.tvSeasonInfo
                                  ?.posterPathUrl?.prefixTmdbImgPath,
                            ),
                          ),
                          AppSpace.size10,
                          if (episodeItem.tvSeasonInfo?.description != null)
                            Flexible(
                              child: Text(
                                episodeItem.tvSeasonInfo?.description == null ||
                                        episodeItem.tvSeasonInfo?.description ==
                                            ''
                                    ? '내용 없음'
                                    : episodeItem.tvSeasonInfo!.description,
                                style: AppTextStyle.body3,
                              ),
                            ),
                          // 데이터가 없으면 skeleton을 노출
                          if (episodeItem.tvSeasonInfo?.description == null)
                            Column(
                              children: [
                                SkeletonBox(
                                  height: 16,
                                  width: SizeConfig.to.screenWidth -
                                      vm.seasonEpisodeImgWidth -
                                      42,
                                ),
                                AppSpace.size2,
                                SkeletonBox(
                                  height: 16,
                                  width: SizeConfig.to.screenWidth -
                                      vm.seasonEpisodeImgWidth -
                                      42,
                                ),
                                AppSpace.size2,
                                SkeletonBox(
                                  height: 16,
                                  width: SizeConfig.to.screenWidth -
                                      vm.seasonEpisodeImgWidth -
                                      42,
                                ),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (_, __) => AppSpace.size16,
            ),
          ],
        ),
      );
}
