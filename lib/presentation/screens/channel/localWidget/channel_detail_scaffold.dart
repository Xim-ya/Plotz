import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/utilities/index.dart';

class ChannelDetailScaffold extends StatelessWidget {
  const ChannelDetailScaffold({
    Key? key,
    required this.channelInfoView,
    required this.pagedPosterGridView,
    required this.scrollController,
    required this.appBar,
    required this.stackedTopGradientBox,
  }) : super(key: key);

  final ScrollController scrollController;
  final Widget channelInfoView;
  final Widget pagedPosterGridView;
  final Widget appBar;
  final Widget stackedTopGradientBox;

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Padding(
        padding: AppInset.horizontal16,
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            // 채널 정보섹션
            SliverToBoxAdapter(
              child: channelInfoView,
            ),
            pagedPosterGridView,
            const SliverToBoxAdapter(
              child: SizedBox(height: 106),
            ),
          ],
        ),
      ),

      // 상단 Gradient
      Positioned(
        top: 0,
        child: IgnorePointer(
          child: stackedTopGradientBox,
        ),
      ),

      // 하단 Gradient
      Positioned(
        bottom: 0,
        child: IgnorePointer(
          child: Container(
            height: 156,
            width: SizeConfig.to.screenWidth,
            decoration: const BoxDecoration(
              gradient: AppGradient.bottomToTop,
            ),
          ),
        ),
      ),

      // 앱바
      Positioned(
        top: SizeConfig.to.statusBarHeight,
        child: appBar,
      ),
    ]);
  }
}
