// import 'package:uppercut_fantube/utilities/index.dart';
//
// class ExploreScaffold extends StatelessWidget {
//   const ExploreScaffold({Key? key}) : super(key: key);
//
//   final Widget backdropImg;
//   final Widget contentInfoView;
//   final Widget topFixedActionButton;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         CarouselSlider.builder(
//           itemCount: 20,
//           options: CarouselOptions(
//             disableCenter: true,
//             height: double.infinity,
//             scrollDirection: Axis.vertical,
//             enableInfiniteScroll: false,
//             viewportFraction: 1,
//           ),
//           itemBuilder:
//               (BuildContext context, int parentIndex, int pageViewIndex) {
//             /// Top Content Section
//             return Stack(
//               children: [
//                 Align(
//                   alignment: Alignment.topCenter,
//                   child: CachedNetworkImage(
//                     imageUrl:
//                     '/ggFHVNu6YYI5L9pCfOacjizRGt.jpg'.prefixTmdbImgPath,
//                     height: double.infinity,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 Positioned.fill(
//                   child: Container(
//                     decoration: const BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [
//                           Colors.black,
//                           Colors.transparent,
//                           AppColor.black
//                         ],
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         stops: <double>[0.06, 0.3, 0.92],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 0,
//                   child: Padding(
//                     padding: AppInset.horizontal16,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         // 제목 & 개봉년도
//                         Row(
//                           children: <Widget>[
//                             Obx(
//                                   () => vm.headerTitle.hasData
//                                   ? Text(vm.headerTitle!,
//                                   style: AppTextStyle.headline2)
//                                   : Shimmer(
//                                 color: AppColor.lightGrey,
//                                 child: const SizedBox(
//                                   height: 28,
//                                   width: 40,
//                                 ),
//                               ),
//                             ),
//                             AppSpace.size6,
//                             Obx(
//                                   () => Text(
//                                 vm.releaseDate.hasData
//                                     ? Formatter.dateToyyMMdd(vm.releaseDate!)
//                                     : '-',
//                                 style: AppTextStyle.alert2,
//                               ),
//                             )
//                           ],
//                         ),
//                         AppSpace.size6,
//                         // 컨텐츠 설명
//                         SizedBox(
//                           width: SizeConfig.to.screenWidth - 32,
//                           child: Text(
//                             '수십 년 전 잠적한 전직 CIA 요원 댄 체이스. 과거의 비밀을 안고 은둔한 채 살아가던 중 결국 정체가 탄로 난다. 하지만 미래를 위해서 더 이상 숨어 살 수 없는 그는 과거의 매듭을 풀고자 하는데.',
//                             maxLines: 3,
//                             overflow: TextOverflow.ellipsis,
//                             style: AppTextStyle.title1,
//                           ),
//                         ),
//                         AppSpace.size24,
//                         // 채널 정보
//                         Obx(
//                               () => ChannelInfoView(
//                             channelImgUrl: vm.channelImgUrl,
//                             channelName: vm.channelName,
//                             subscriberCount: vm.subscriberCount,
//                           ),
//                         ),
//                         AppSpace.size20,
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//         Positioned(
//           top: SizeConfig.to.statusBarHeight + 16,
//           right: 0,
//           child: MaterialButton(
//             minWidth: 0,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(100),
//             ),
//             height: 0,
//             padding: const EdgeInsets.all(6),
//             onPressed: () {},
//             child: const Icon(
//               Icons.refresh,
//               size: 28,
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
