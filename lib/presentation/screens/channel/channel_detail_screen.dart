import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:soon_sak/app/config/app_space_config.dart';
import 'package:soon_sak/app/config/color_config.dart';
import 'package:soon_sak/app/config/font_config.dart';
import 'package:soon_sak/presentation/base/new_base_screen.dart';
import 'package:soon_sak/presentation/common/gridView/paged_grid_list_view.dart';
import 'package:soon_sak/presentation/common/image/circle_img.dart';
import 'package:soon_sak/presentation/screens/channel/channel_detail_view_model.dart';
import 'package:soon_sak/utilities/formatter.dart';

class ChannelDetailScreen extends NewBaseScreen<ChannelDetailViewModel> {
  const ChannelDetailScreen({Key? key}) : super(key: key);

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) => AppBar(
        elevation: 0,
        backgroundColor: AppColor.black,
        leading: IconButton(
          onPressed: Get.back,
          icon: SvgPicture.asset(
            'assets/icons/left_arrow.svg',
            height: 24,
            width: 24,
          ),
        ),
      );

  @override
  Widget buildScreen(BuildContext context) {
    return CustomScrollView(
      controller: vm(context).scrollController,
      slivers: [
        // 채널 정보섹션
        SliverToBoxAdapter(
          child: Column(
            children: <Widget>[
              AppSpace.size4,
              GestureDetector(
                onTap: () {
                  print(vm(context).contents.length);
                },
                child: CircleImg(
                  imgUrl: vm(context).channelInfo.logoImgUrl,
                  size: 90,
                ),
              ),
              AppSpace.size8,
              SizedBox(
                width: double.infinity - 32,
                child: Text(
                  vm(context).channelInfo.name,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.headline1,
                ),
              ),
              AppSpace.size4,
              Text(
                '구독자 ${Formatter.formatNumberWithUnit(vm(context).channelInfo.subscribersCount)}명',
                style: AppTextStyle.alert2.copyWith(
                  color: AppColor.gray04,
                ),
              ),
            ],
          ),
        ),
        PagedGridListView(
          pagingController: vm(context).pagingController,
          itemBuilder: (BuildContext context, dynamic item, int index) {
            return Container(
              color: Colors.red,
            );
          },
        )
      ],
    );
  }

  @override
  ChannelDetailViewModel createViewModel() =>
      Get.put(ChannelDetailViewModel(Get.find(), argument: Get.arguments));
}
