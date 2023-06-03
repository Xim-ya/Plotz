import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:soon_sak/domain/model/content/home/new_content_poster_shell.dart';
import 'package:soon_sak/domain/model/video/content_video_model.dart';
import 'package:soon_sak/presentation/base/base_view.dart';
import 'package:soon_sak/presentation/common/image/new_content_post_item.dart';
import 'package:soon_sak/presentation/common/skeleton_box.dart';
import 'package:soon_sak/utilities/index.dart';
import 'package:tuple/tuple.dart';

class ContentInfoTabView extends BaseView<ContentDetailViewModel> {
  const ContentInfoTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        AppSpace.size36,

        // 비디오 정보 (조회수, 좋아요, 업로드일 )
        _VideoInfoView(),
        AppSpace.size48,

        // 채널 정보
        _ChannelInfoView(),
        AppSpace.size48,

        // 채널의 다른 콘텐츠
        _ChannelRelatedContentView(),

        // 유튜버의 다른 콘텐츠
      ],
    );
  }
}

// 채널의 다른 콘텐츠
class _ChannelRelatedContentView extends BaseView<ContentDetailViewModel> {
  const _ChannelRelatedContentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: AppInset.left16,
          child: Text(
            '채널의 다른 콘텐츠',
            style: AppTextStyle.title2,
          ),
        ),
        AppSpace.size8,
        Selector<ContentDetailViewModel, List<NewContentPosterShell>?>(
            selector: (_, vm) => vm.channelRelatedContents,
            builder: (context, contents, _) {
              if (contents?.length == 0) {
                return Padding(
                  padding: AppInset.left16,
                  child: Text(
                    '관련 콘텐츠가 없습니다',
                    style: AppTextStyle.body3.copyWith(color: AppColor.gray03),
                  ),
                );
              } else {
                return ContentPostSlider(
                  height: 158,
                  itemCount: contents?.length ?? 6,
                  itemBuilder: (context, index) {
                    if (contents.hasData) {
                      final item = contents![index];
                      return NewContentPostItem(
                        imgUrl: item.posterImgUrl,
                        title: item.title,
                      );
                    } else {
                      return NewContentPostItem.createSkeleton();
                    }
                  },
                );
              }
            }),
      ],
    );
  }
}

// 채널 정보
class _ChannelInfoView extends BaseView<ContentDetailViewModel> {
  const _ChannelInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<ContentDetailViewModel, ChannelInfo?>(
      selector: (_, vm) => vm.channelInfo,
      child: _skeleton(),
      builder: (context, channel, skeleton) {
        return GestureDetector(
          onTap: () {
            if (!channel.hasData) return;
          },
          child: Container(
            width: double.infinity,
            padding: AppInset.horizontal16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 채널
                Text(
                  '채널',
                  style: AppTextStyle.title2,
                ),
                AppSpace.size8,
                if (vm(context).channelImgUrl.hasData)
                  Row(
                    children: [
                      RoundProfileImg(
                        size: 64,
                        imgUrl: vm(context).channelImgUrl,
                      ),
                      AppSpace.size12,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('영읽남', style: AppTextStyle.body1),
                          AppSpace.size2,
                          Text(
                            '구독자 ${Formatter.formatNumberWithUnit(vm(context).subscriberCount)}명',
                            style: AppTextStyle.alert2.copyWith(
                              color: AppColor.gray03,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      SvgPicture.asset('assets/icons/see_more.svg')
                    ],
                  )
                else
                  skeleton!
              ],
            ),
          ),
        );
      },
    );
  }

  Row _skeleton() {
    return Row(
      children: [
        RoundProfileImg.createSkeleton(size: 62),
        AppSpace.size12,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SkeletonBox(
              padding: AppInset.vertical2,
              height: 18,
              width: 40,
            ),
            AppSpace.size2,
            SkeletonBox(
              padding: AppInset.vertical2,
              height: 14,
              width: 56,
            ),
          ],
        ),
        const Spacer(),
        SvgPicture.asset('assets/icons/see_more.svg')
      ],
    );
  }
}

// 비디오 정보 (조회수, 좋아요, 업로드일 )
class _VideoInfoView extends BaseView<ContentDetailViewModel> {
  const _VideoInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<
        ContentDetailViewModel,
        Tuple3<BehaviorSubject<int?>?, BehaviorSubject<int?>?,
            BehaviorSubject<String?>?>>(
      selector: (_, vm) => Tuple3(vm.videoInfo?.mainViewCount,
          vm.videoInfo?.mainLikesCount, vm.videoInfo?.mainUploadDate),
      builder: (context, value, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            StreamBuilder<int?>(
              stream: value.item1?.stream,
              builder: (context, snapshot) {
                return _columnItem(
                    title: '조회수',
                    iconName: 'small_eye',
                    data: Formatter.formatNumberWithUnit(snapshot.data));
              },
            ),
            StreamBuilder<int?>(
              stream: value.item2?.stream,
              builder: (context, snapshot) {
                return _columnItem(
                    title: '좋아요',
                    iconName: 'small_like',
                    data: Formatter.formatNumberWithUnit(snapshot.data));
              },
            ),
            StreamBuilder<String?>(
              stream: value.item3?.stream,
              builder: (context, snapshot) {
                return _columnItem(
                    title: '업로드일',
                    iconName: 'small_date',
                    data: Formatter.getDateDifferenceFromNow(snapshot.data));
              },
            ),
          ],
        );
      },
    );
    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
    //   children: <Widget>[
    //     _columnItem(title: '조회수', iconName: 'small_eye', data: value.item1),
    //     _columnItem(title: '좋아요', iconName: 'small_like', data: value.item2),
    //     StreamBuilder<String?>(
    //         stream: value.item3,
    //         builder: (context, snapshot) {
    //           return _columnItem(
    //               title: '업로드일', iconName: 'small_date', data: snapshot.data);
    //         })
    //   ],
    // );
  }

  SizedBox _columnItem(
      {required String title,
      required String iconName,
      required String? data}) {
    return SizedBox(
      height: 54,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              SvgPicture.asset(
                'assets/icons/$iconName.svg',
              ),
              AppSpace.size6,
              Text(
                title,
                style: AppTextStyle.nav.copyWith(
                  color: AppColor.gray03,
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            child: Center(
              child: Text(
                data ?? '',
                textAlign: TextAlign.center,
                style: AppTextStyle.title3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
