import 'package:provider/provider.dart';
import 'package:soon_sak/presentation/base/base_view.dart';
import 'package:soon_sak/utilities/index.dart';

class CompletedContentsTabView extends BaseView<CurationHistoryViewModel> {
  const CompletedContentsTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CurationHistoryViewModel>(
      builder: (context, vm, _) {
        if (vmS<ViewModelLoadingState>(context, (vm) => vm.loadingState) ==
            ViewModelLoadingState.done) {
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
