import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/domain/enum/requested_content_status.dart';
import 'package:soon_sak/domain/model/content/myPage/requested_content.m.dart';
import 'package:soon_sak/presentation/base/base_view.dart';
import 'package:soon_sak/presentation/screens/requested_content/local_widgets/requested_content_item_view.dart';
import 'package:soon_sak/presentation/screens/requested_content/requested_content_board_view_model.dart';
import 'package:soon_sak/utilities/data_status.dart';
import 'package:soon_sak/utilities/index.dart';

class RequestedContentStatusListView
    extends BaseView<RequestedContentBoardViewModel> {
  const RequestedContentStatusListView(this.statusKey, {Key? key})
      : super(key: key);

  final int statusKey;

  @override
  Widget build(BuildContext context) {
    return Selector<RequestedContentBoardViewModel, Ds<List<RequestedContent>>>(
      selector: (context, vm) => vm.getContentsByKey(statusKey),
      builder: (context, list, _) {
        if (list.cycle.isFailed) {
          return Center(
            child: Text(
              '오류가 발생했어요',
              style: AppTextStyle.title1,
            ),
          );
        }

        if (list.cycle.isFetched && list.value!.isEmpty) {
          return Center(
            child: Text(
              '${RequestedContentStatus.fromKeyValue(key: statusKey, pendingReason: null).text}된 콘텐츠가 없어요',
              style: AppTextStyle.title1,
            ),
          );
        }

        return ListView.separated(
          padding: AppInset.horizontal16 + AppInset.top24 + AppInset.bottom36,
          separatorBuilder: (_, __) => AppSpace.size16,
          itemCount: vmW(context)
                  .requestedContentCollection[statusKey]
                  .value
                  ?.length ??
              0,
          itemBuilder: (context, index) {
            if (list.cycle.isLoadingOrInitial) {
              return RequestedContentItemView.createSkeleton();
            }
            final item = list.value![index];

            return RequestedContentItemView(
              content: item,
              onContentTapped: () {
                vm(context).onRegisteredContentTapped(item);
              },
            );
          },
        );
      },
    );
  }
}
