import 'package:soon_sak/utilities/index.dart';

class LeadingIconTitle extends StatelessWidget {
  const LeadingIconTitle({Key? key, required this.title, required this.icon})
      : super(key: key);

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInset.left16,
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColor.mixedWhite,
          ),
          AppSpace.size4,
          Text(
            title,
            style: AppTextStyle.headline2.copyWith(color: AppColor.mixedWhite),
          )
        ],
      ),
    );
  }
}
