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
        borderRadius: BorderRadius.circular(4),
      ),
      height: 48,
      padding: EdgeInsets.zero,
      color: sns.bgColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 32,
            width: 32,
            child: SvgPicture.asset('assets/icons/${sns.logoPath}'),
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            '${sns.name}로 아이디로 로그인하기',
            style: AppTextStyle.body2.copyWith(color: sns.textColor),
          )
        ],
      ),
    );
  }
}
