part of '../register_view_model.dart';


extension FindContentViewModel on RegisterViewModel {

  void onSearchedContentTapped(int contentId) {
    selectedContentId.value = contentId;
    print(selectedContentId);
  }
}
