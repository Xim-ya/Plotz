import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:uppercut_fantube/app/config/app_insets.dart';
import 'package:uppercut_fantube/app/config/color_config.dart';
import 'package:uppercut_fantube/app/config/font_config.dart';

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
