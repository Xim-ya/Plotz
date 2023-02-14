
import 'package:soon_sak/domain/enum/validation_state_enum.dart';
import 'package:soon_sak/utilities/index.dart';

class UrlValidationIndicator extends StatelessWidget {
  const UrlValidationIndicator({Key? key, required this.validationState})
      : super(key: key);

  final ValidationState validationState;

  @override
  Widget build(BuildContext context) {
    switch (validationState) {
      case ValidationState.initState:
        return const SizedBox();
      case ValidationState.isLoading:
        return const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2.6,
            color: AppColor.darkGrey,
          ),
        );
      case ValidationState.valid:
        return Row(
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: AppColor.green,
              size: 14,
            ),
            AppSpace.size4,
            Text(
              '입력되었어요',
              style: AppTextStyle.alert2.copyWith(color: AppColor.green),
            ),
          ],
        );
      case ValidationState.invalid:
        return Row(
          children: [
            const Icon(
              Icons.error_outline,
              color: AppColor.red,
              size: 14,
            ),
            AppSpace.size4,
            Text(
              '잘못된 링크 입니다',
              style: AppTextStyle.alert2.copyWith(color: AppColor.red),
            ),
          ],
        );
    }
  }
}