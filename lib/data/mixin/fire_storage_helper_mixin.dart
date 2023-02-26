import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:soon_sak/data/firebase/app_fire_storage.dart';

mixin FireStorageHelper {
  final _db = AppFireStorage.getInstance;

  /// 폴더 특정 소스파일을 저장하고
  /// File Path Url을 리턴받는 메소
  Future<String> storeFileAndReturnDownloadUrl(
    String folderName, {
    required String fileId,
    required File file,
  }) async {
    final storageRef = _db.ref(folderName).child(fileId);
    final uploadTask = storageRef.putFile(file);
    final snapshot = await uploadTask.whenComplete(() {});

    if (snapshot.state == TaskState.success) {
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } else {
      throw 'storeFileAndReturnDownloadUrl : 데이터 저장에 실패했습니다';
    }
  }
}
