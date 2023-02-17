import 'package:flutter/material.dart';

@immutable
class ContentException extends FormatException {
  const ContentException(String message) : super(message);

  // 큐레이션 정보 등록 실패
  factory ContentException.qurationRequestFailed() =>
      const ContentException('큐레이션 컨텐츠 등록에 실패했습니다');

  factory ContentException.updateUserQurationInfoFailed() =>
      const ContentException('유저의 컨텐츠 등록 요청을 저장하지 못했습니다');

  @override
  String toString() {
    return message;
  }
}
