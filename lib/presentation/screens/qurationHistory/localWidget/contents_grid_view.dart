import 'package:soon_sak/utilities/index.dart';

class ContentsGridView extends StatelessWidget {
  const ContentsGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInset.horizontal16 + AppInset.top20,
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: 4,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 34,
          crossAxisSpacing: 8,
          childAspectRatio: 0.5,
        ),
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ContentPostItem(
                imgUrl: '/f2PVrphK0u81ES256lw3oAZuF3x.jpg',
              ),
              const SizedBox(height: 1),
              SizedBox(
                width: 90,
                child: Text(
                  '인셉션',
                  style: AppTextStyle.body2,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '영화',
                style: AppTextStyle.alert1.copyWith(
                  color: AppColor.lightGrey,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
