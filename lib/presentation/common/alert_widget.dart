import 'package:uppercut_fantube/utilities/index.dart';

/** Created By Ximya - 2022.12.10
 * toast과
 * */

class AlertWidget {
  static Future<void> toast(String error) async {
    showToastWidget(
      Container(
        key: const Key('toast'),
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black,
        ),
        margin:  AppInset.horizontal16,
        padding: AppInset.vertical12 + AppInset.horizontal20,
        child: Text(
          error,
          style: AppTextStyle.body3.copyWith(color: AppColor.mixedWhite),
        ),
      ),
      context: Get.context,
      animDuration: Duration.zero,
    );
  }



}
