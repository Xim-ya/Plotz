import 'package:soon_sak/utilities/index.dart';

class CompletedContentsTabView extends BaseView<CurationHistoryViewModel> {
  const CompletedContentsTabView({Key? key}) : super(key: key);

  @override
  Widget buildView(BuildContext context) {
    return GetBuilder<CurationHistoryViewModel>(
      builder: (_) {
        if (vm.loading.isFalse) {
          return ContentsGridView(contents: vm.completedCurationList);
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
