import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/utilities/index.dart';

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({
    Key? key,
    required this.focusNode,
    required this.textEditingController,
    required this.onChanged,
    this.onFieldSubmitted,
    required this.resetSearchValue,
    required this.showRoundCloseBtn,
    this.showPrefixIcon = true,
    this.width = double.infinity,
    this.hintText = '제목을 입력하세요',
  }) : super(key: key);

  final FocusNode focusNode;
  final TextEditingController textEditingController;
  final Function(String) onChanged;
  final Function(String)? onFieldSubmitted;
  final VoidCallback resetSearchValue;
  final bool showRoundCloseBtn;
  final double width;
  final String? hintText;
  final bool? showPrefixIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      width: width, // check
      child: Stack(
        children: [
          TextFormField(
            onFieldSubmitted: onFieldSubmitted,
            keyboardAppearance: Brightness.dark,
            focusNode: focusNode,
            onChanged: onChanged,
            controller: textEditingController,
            cursorColor: AppColor.lightGrey,
            style: AppTextStyle.body2,
            decoration: InputDecoration(
              filled: true,
              contentPadding:
                  EdgeInsets.only(left: showPrefixIcon! ? 36 : 14, right: 40),
              hintText: hintText,
              errorBorder: InputBorder.none,
              enabledBorder: _fixedOutLinedBorder(),
              disabledBorder: _fixedOutLinedBorder(),
              focusedBorder: _fixedOutLinedBorder(),
              fillColor: AppColor.strongGrey,
              hintStyle: AppTextStyle.body2.copyWith(
                color: AppColor.gray03,
              ),
            ),
          ),
          // 검색창 prefix 검색 아이콘
          if (showPrefixIcon!)
            Positioned(
              left: 8,
              top: 0,
              bottom: 0,
              child: SvgPicture.asset(
                height: 24,
                width: 24,
                'assets/icons/search.svg',
              ),
            ),

          // 'X' 버튼
          if (showRoundCloseBtn)
            Positioned(
              right: 12,
              top: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: resetSearchValue,
                child: SvgPicture.asset(
                  'assets/icons/close_rounded.svg',
                  height: 16,
                  width: 16,
                ),
              ),
            )
          else
            const SizedBox(),
        ],
      ),
    );
  }

  // [TextField] OutLinedBorder 속성
  OutlineInputBorder _fixedOutLinedBorder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(6)),
      borderSide: BorderSide(color: Colors.transparent),
    );
  }
}
