import 'package:uppercut_fantube/utilities/index.dart';

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
      case null:
        return _buildSkeletonView();
      case ContentVideoFormat.singleMovie:
        return _buildSingleMovieVideoView();
      case ContentVideoFormat.multipleMovie:
        return _buildMultipleMoviesVideoView();
      case ContentVideoFormat.singleTv:
        return _buildSingleTvVideoView();
      case ContentVideoFormat.multipleTv:
        return _buildMultipleTvVideoView();
    }
  }

  Widget _buildSingleMovieVideoView() => Padding(
        padding: AppInset.horizontal16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SectionTitle(title: '컨텐츠'),
            Obx(
              () => VideoThumbnailImgWithPlayerBtn(
                onPlayerBtnClicked: () {
                  // vm.launchYoutubeApp(vm.youtubeContentId);
                },
                posterImgUrl: vm.singleVideoThumbnailUrl,
              ),
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
                      Obx(
                        () => vm.singleLikesCount.hasData
                            ? Text(
                                vm.singleLikesCount!,
                                style: AppTextStyle.body3,
                              )
                            : Padding(
                                padding: const EdgeInsets.only(left: 2),
                                child: Shimmer(
                                  color: AppColor.lightGrey,
                                  child: const SizedBox(
                                    height: 16,
                                    width: 20,
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                  Obx(
                    () => vm.singleVideoViewCount.hasData &&
                            vm.singleUploadDate.hasData
                        ? Text(
                            '조회수 ${vm.singleVideoViewCount} · ${vm.singleUploadDate}',
                            style: AppTextStyle.body3,
                          )
                        : Row(
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
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _buildMultipleMoviesVideoView() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: AppInset.horizontal16,
            child: SectionTitle(title: '컨텐츠'),
          ),
          Obx(
            () => CarouselSlider.builder(
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
                      VideoThumbnailImgWithPlayerBtn(
                        onPlayerBtnClicked: () {
                          // vm.launchYoutubeApp(vm.youtubeContentId);
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
                                Obx(
                                  () => vm.multipleVideoInfo.hasData
                                      ? Text(
                                          videoInfoItem.detailInfo!.likeCount
                                              .toString(),
                                          style: AppTextStyle.body3,
                                        )
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(left: 2),
                                          child: Shimmer(
                                            color: AppColor.lightGrey,
                                            child: const SizedBox(
                                              height: 16,
                                              width: 20,
                                            ),
                                          ),
                                        ),
                                ),
                              ],
                            ),
                            Obx(
                              () => vm.multipleVideoInfo.hasData
                                  ? Text(
                                      '조회수 ${Formatter.formatViewAndLikeCount(videoInfoItem.detailInfo?.viewCount, isViewCount: true)} · ${Formatter.getDateDifferenceFromNow(videoInfoItem.detailInfo!.uploadDate!)}',
                                      style: AppTextStyle.body3,
                                    )
                                  : Row(
                                      children: <Widget>[
                                        Shimmer(
                                          child: Container(
                                            color: AppColor.lightGrey
                                                .withOpacity(0.1),
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
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      );

  Widget _buildSingleTvVideoView() => Container();

  Widget _buildMultipleTvVideoView() => Container();

  Widget _buildSkeletonView() => Container();
}
