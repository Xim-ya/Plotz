import 'package:uppercut_fantube/utilities/index.dart';

/** Created By Ximya - 2022.11.05
 *  - [InkWell] 효과를 적용한 아이콘 버튼
 *  - [MaterialButton]를 기반으로 함
 *    - [MaterialButton]을 상속 받아서 모듈을 구성하려고 했지만 색상이 이상해지는 오류가 존재했었음.
 *  - [MaterialButton]의 기본 사이즈 및 패딩을 제거함.
 * */

class IconInkWellButton extends StatelessWidget {
  const IconInkWellButton({super.key, required this.iconPath, required this.iconSize, required this.onIconTapped});

  final String iconPath;
  final double iconSize;
  final VoidCallback onIconTapped;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
      height: 0,
      padding: EdgeInsets.zero,
      onPressed: onIconTapped,
      child: SvgPicture.asset(
       iconPath,
        height: iconSize,
        width: iconSize,
      ),
    );
  }

}