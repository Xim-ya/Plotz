import 'package:flutter/material.dart';

@immutable
class UserException extends FormatException {
  const UserException(String message) : super(message);

  // 유저 큐레이션 필드에 데이터 저장 실패
  factory UserException.updateUserQurationInfoFailed() =>
      const UserException('유저의 큐레이션 정보를 저장하지 못했습니다');

  @override
  String toString() {
    return message;
  }
}
