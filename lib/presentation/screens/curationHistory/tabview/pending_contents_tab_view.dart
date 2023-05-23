import 'package:provider/provider.dart';
import 'package:soon_sak/presentation/base/new_base_view.dart';
import 'package:soon_sak/utilities/index.dart';

class PendingContentsTabView extends NewBaseView<CurationHistoryViewModel> {
  const PendingContentsTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CurationHistoryViewModel>(
      builder: (context, vm, _) {
        if (vmS<ViewModelLoadingState>(context, (vm) => vm.loadingState) ==
            ViewModelLoadingState.done) {
          return ContentsGridView(contents: vm.onHoldCurationList);
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
