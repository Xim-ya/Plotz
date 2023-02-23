import 'package:soon_sak/utilities/index.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
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
  final RxBool showRoundCloseBtn;
  final double width;
  final String? hintText;
  final bool? showPrefixIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
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
            style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontFamily: 'pretendard_regular'),
            decoration: InputDecoration(
              filled: true,
              contentPadding:
                  EdgeInsets.only(left: showPrefixIcon! ? 38 : 14, right: 40),
              hintText: hintText,
              errorBorder: InputBorder.none,
              enabledBorder: _fixedOutLinedBorder(),
              disabledBorder: _fixedOutLinedBorder(),
              focusedBorder: _fixedOutLinedBorder(),
              fillColor: AppColor.strongGrey,
              hintStyle: TextStyle(
                fontSize: 16,
                color: AppColor.lightGrey.withOpacity(0.4),
                fontFamily: 'pretendard_regular',
              ),
            ),
          ),

          // 검색창 prefix 검색 아이콘
          if (showPrefixIcon!)
            Positioned(
              child: Container(
                alignment: Alignment.center,
                width: 40,
                child: const Icon(
                  Icons.search_rounded,
                  color: AppColor.lightGrey,
                ),
              ),
            ),

          // 'X' 버튼
          Obx(() => showRoundCloseBtn.value
              ? Positioned(
                  right: 0,
                  child: GestureDetector(
                    onTap: resetSearchValue,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 40,
                      child: Container(
                        width: 18,
                        height: 18,
                        decoration: const BoxDecoration(
                          color: AppColor.lightGrey,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close_rounded,
                          size: 12,
                          color: AppColor.strongGrey,
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox()),
        ],
      ),
    );
  }

  // [TextField] OutLinedBorder 속성
  OutlineInputBorder _fixedOutLinedBorder() {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        borderSide: BorderSide(color: Colors.transparent));
  }
}
