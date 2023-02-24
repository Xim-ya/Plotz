import 'package:soon_sak/utilities/index.dart';

class SingleVideoSkeletonView extends StatelessWidget {
  const SingleVideoSkeletonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInset.horizontal16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SectionTitle(title: '컨텐츠'),
          ImageViewWithPlayBtn(
            onPlayerBtnClicked: () {
              AlertWidget.toast('잠시만 기다려 주세요. 데이터를 불러오고 있습니다.');
            },
            posterImgUrl: null,
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
  }
}
