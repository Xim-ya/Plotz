import 'package:uppercut_fantube/presentation/screens/quration/register/register_view_model.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class FindContentView extends BaseView<RegisterViewModel> {
  const FindContentView({Key? key}) : super(key: key);

  @override
  Widget buildView(BuildContext context) {
    return Padding(
      padding: AppInset.horizontal16,
      child: Column(
        children: <Widget>[
          AppSpace.size10,
          SearchBar(
            focusNode: vm.focusNode,
            textEditingController: vm.textEditingController,
            onChanged: (String input) {},
            onFieldSubmitted: (String result) {},
            resetSearchValue: vm.resetSearchValue,
            showRoundCloseBtn: vm.showRoundCloseBtn,
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}
