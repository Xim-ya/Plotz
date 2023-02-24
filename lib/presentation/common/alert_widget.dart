import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2022.12.10
 * toast과
 * */

class AlertWidget {
  static Future<void> toast(String error) async {
    showToastWidget(
      Container(
        key: const Key('toast'),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black,
        ),
        margin: AppInset.horizontal16,
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

  static Future<void> animatedToast(String message,
      {bool? isUsedOnTabScreen}) async {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: AppColor.black,
        borderRadius: 8,
        margin: isUsedOnTabScreen.hasData && isUsedOnTabScreen == true
            ? AppInset.bottom46 + AppInset.horizontal8
            : AppInset.horizontal8,
        padding: AppInset.horizontal24  + AppInset.vertical16,
        messageText: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: AppTextStyle.body1.copyWith(color: Colors.white),
            )
          ],
        ),
        dismissDirection: DismissDirection.endToStart,
        duration: const Duration(milliseconds: 1200),
      ),
    );
  }


  static Future<void> newToast(String message,
      {bool? isUsedOnTabScreen}) async {
    showToastWidget(
      Container(
        key: const Key('toast'),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.black,
        ),
        height: 52,
        width: double.infinity,
        margin: isUsedOnTabScreen.hasData && isUsedOnTabScreen == true
            ? AppInset.bottom46 + AppInset.horizontal8
            : AppInset.horizontal8,
        padding: AppInset.left24,
        child: Center(
          child: SizedBox(
            width: double.infinity,
            child: Text(
              message,
              style: AppTextStyle.body2.copyWith(color: AppColor.mixedWhite),
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ),
      context: Get.context,
      animDuration: Duration.zero,
    );
  }
}
