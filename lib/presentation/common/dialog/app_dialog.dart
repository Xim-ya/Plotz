import 'package:soon_sak/utilities/index.dart';

/* Created By Ximya - 2022.12.25 🎄🎄🎄
*  앱에서 사용되는 다이어로그 모듈
*  IOS Cupertino 기본 다이로그와 유사한 레이아웃
*  단일 버튼 레이아웃 & 2개의 버튼 레이아웃으로 구성되어 있음.
*  [factory pattern]으로 각각 필요한 paramter을 전달받고 위젯을 반환함 (명시성을 높이기 위해).
* */

class AppDialog extends Dialog {
  const AppDialog({
    Key? key,
    this.isDividedBtnFormat = false,
    this.description,
    this.onLeftBtnClicked,
    this.leftBtnContent,
    required this.btnContent,
    required this.onBtnClicked,
    required this.title,
  }) : super(key: key);

  factory AppDialog.singleBtn({
    required String title,
    required VoidCallback onBtnClicked,
    String? description,
    String? btnContent,
  }) =>
      AppDialog(
        title: title,
        onBtnClicked: onBtnClicked,
        description: description,
        btnContent: btnContent,
      );

  factory AppDialog.dividedBtn({
    required String title,
    String? description,
    required String leftBtnContent,
    required String rightBtnContent,
    required VoidCallback onRightBtnClicked,
    required VoidCallback onLeftBtnClicked,
  }) =>
      AppDialog(
        isDividedBtnFormat: true,
        title: title,
        onBtnClicked: onRightBtnClicked,
        onLeftBtnClicked: onLeftBtnClicked,
        description: description,
        leftBtnContent: leftBtnContent,
        btnContent: rightBtnContent,
      );

  final bool isDividedBtnFormat;
  final String title;
  final String? description;
  final VoidCallback onBtnClicked;
  final VoidCallback? onLeftBtnClicked;
  final String? btnContent;
  final String? leftBtnContent;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        margin: AppInset.horizontal16,
        constraints: const BoxConstraints(minHeight: 120, maxWidth: 290),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColor.strongGrey,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 본분
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 24),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      title,
                      style: AppTextStyle.headline3.copyWith(height: 1.4),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  if (description.hasData) ...[
                    AppSpace.size10,
                    Center(
                      child: Text(
                        description!,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.body3
                            .copyWith(color: AppColor.lightGrey, height: 1.3),
                      ),
                    )
                  ]
                ],
              ),
            ),
            // 하단 버튼

            // 두개의 버튼으로 나누어진 형식이라면 아래 위젯을 러틴
            if (isDividedBtnFormat)
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: AppColor.lightGrey.withOpacity(0.4),
                      width: 0.5,
                    ),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: MaterialButton(
                        padding: EdgeInsets.zero,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                        onPressed: onLeftBtnClicked,
                        child: Center(
                          child: Text(
                            leftBtnContent!,
                            style: AppTextStyle.title1
                                .copyWith(color: AppColor.yellow),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 0.5,
                      color: AppColor.lightGrey.withOpacity(0.4),
                    ),
                    Expanded(
                      child: MaterialButton(
                        padding: EdgeInsets.zero,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        onPressed: onBtnClicked,
                        child: Center(
                          child: Text(
                            btnContent ?? '확인',
                            style: AppTextStyle.title1
                                .copyWith(color: AppColor.yellow),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // 하나의 버튼으로 구성되어 있는 다이어로그 라면 아래 위젯을 리턴
            if (isDividedBtnFormat == false)
              MaterialButton(
                padding: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                onPressed: onBtnClicked,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: AppColor.lightGrey.withOpacity(0.4),
                        width: 0.5,
                      ),
                    ),
                  ),
                  height: 50,
                  child: Center(
                    child: Text(
                      btnContent ?? '확인',
                      style:
                          AppTextStyle.title1.copyWith(color: AppColor.yellow),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
