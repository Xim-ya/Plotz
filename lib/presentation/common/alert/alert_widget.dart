import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:soon_sak/app/config/app_insets.dart';
import 'package:soon_sak/app/config/color_config.dart';
import 'package:soon_sak/app/config/font_config.dart';
import 'package:soon_sak/app/config/size_config.dart';

/** Created By Ximya - 2022.12.10
 *  toast 메세지 UI로직
 *  'flutter_styled_toast' & 'getx' 라이브러리를 이용함
 *  위 라이브러리 global context를 기반하고 있기 때문에
 *  static한 형태로 쉽게 사용이 가능함
 * */

abstract class AlertWidget {
  AlertWidget._();

  static Future<void> newToast(
    BuildContext context, {
    bool? isUsedOnTabScreen,
    required String message,
  }) async {
    showToastWidget(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        margin: isUsedOnTabScreen != null && isUsedOnTabScreen == true
            ? AppInset.bottom46 + AppInset.horizontal16
            : AppInset.horizontal16,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          color: AppColor.gray06,
        ),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: AppTextStyle.alert2,
        ),
      ),
      context: context,
      animDuration: Duration.zero,
    );
  }
}
