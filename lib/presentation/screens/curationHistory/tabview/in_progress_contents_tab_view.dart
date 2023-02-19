import 'package:soon_sak/utilities/index.dart';

class InProgressContentTabView extends BaseView<CurationHistoryViewModel> {
  const InProgressContentTabView({Key? key}) : super(key: key);

  @override
  Widget buildView(BuildContext context) {
    return GetBuilder<CurationHistoryViewModel>(
      builder: (context) {
        if (vm.loading.isFalse) {
          return ContentsGridView(contents: vm.inProgressCuration);
        } else {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 4.6,
              color: AppColor.darkGrey,
            ),
          );
        }
      },
    );
  }
}
