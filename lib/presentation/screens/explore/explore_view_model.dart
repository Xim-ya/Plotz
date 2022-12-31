import 'package:uppercut_fantube/utilities/index.dart';

class ExploreViewModel extends BaseViewModel {
  String? get headerTitle => '어퍼컷'.obs.value;

  String? get releaseDate => '2022-12-20'.obs.value;

  String? get channelImgUrl =>
      'https://yt3.googleusercontent.com/ytc/AMLnZu9tKXzVPuAGTdZ-jfWmuDYRcZwKZlOm6GWpduKnvg=s900-c-k-c0x00ffffff-no-rj'
          .obs
          .value;

  String? get channelName => '어퍼컷'.obs.value;

  int? get subscriberCount => 3234123.obs.value;
}
