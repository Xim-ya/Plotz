import 'package:soon_sak/utilities/index.dart';

class SnsLoginButton extends StatelessWidget {
  const SnsLoginButton({Key? key, required this.sns, required this.onBtnTapped})
      : super(key: key);

  final Sns sns;
  final VoidCallback onBtnTapped;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onBtnTapped,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      height: 56,
      padding: EdgeInsets.zero,
      color: sns.bgColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset('assets/icons/${sns.logoPath}'),
          AppSpace.size4,
          Text(
            '${sns.name}로 시작하기',
            style: AppTextStyle.title2.copyWith(color: sns.textColor),
          )
        ],
      ),
    );
  }
}
