import 'package:soon_sak/utilities/index.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({Key? key, required this.title, this.setLeftPadding = false})
      : super(key: key);

  final String title;
  final bool? setLeftPadding;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(bottom: 10, left: setLeftPadding! ? 16 : 0),
        child: Text(
          title,
          style: AppTextStyle.headline2.copyWith(color: Colors.white),
        ),
      );
}
