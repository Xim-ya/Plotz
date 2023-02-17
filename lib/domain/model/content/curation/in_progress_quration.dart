import 'package:soon_sak/utilities/index.dart';

class InProgressQurationItem {
  final String posterImgUrl;
  final String curatorName;
  final String curatorProfileImgUrl;

  InProgressQurationItem({
    required this.posterImgUrl,
    required this.curatorName,
    required this.curatorProfileImgUrl,
  });

  factory InProgressQurationItem.fromResponse(
          InProgressCurationItemResponse response) =>
      InProgressQurationItem(
        posterImgUrl: response.posterImgUrl,
        curatorName: response.curatorDisplayName,
        curatorProfileImgUrl: response.curatorProfileImgUrl,
      );
}
