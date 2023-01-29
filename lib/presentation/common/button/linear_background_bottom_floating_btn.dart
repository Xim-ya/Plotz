import 'package:uppercut_fantube/utilities/index.dart';

class LinearBgBottomFloatingBtn extends StatelessWidget {
  const LinearBgBottomFloatingBtn({Key? key, required this.text, required this.onTap}) : super(key: key);

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            // 1: 5 비율
            AppColor.black.withOpacity(0.0),
            AppColor.black,
            AppColor.black,
            AppColor.black,
            AppColor.black,
            AppColor.black
          ],
        ),
      ),
      padding: AppInset.horizontal16 + AppInset.top20,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          color: AppColor.strongGrey,
          width: SizeConfig.to.screenWidth - 32,
          height: 56,

          child: MaterialButton(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            key: key,
            onPressed: onTap,
            child: Text(
              '다음',
              textAlign: TextAlign.center,
              style: AppTextStyle.title2,
            ),
          ),
        ),
      ),
    );
  }
}
