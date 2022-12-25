import 'package:uppercut_fantube/utilities/index.dart';

class AppDialog extends Dialog {
  const AppDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        color: Color(0xFF1F1F20),
      ),
    );
  }
}
