import 'package:flutter/material.dart';

@immutable
class AuthException extends FormatException {
  const AuthException(String message) : super(message);

  // 구글 로그인 시도 중단
  factory AuthException.stopGoogleSignInProcess() =>
      const AuthException('구글 로그인 시도 중단');

  // 애플 로그인 시도 중단
  factory AuthException.stopAppleSignInProgress() =>
      const AuthException('애플 로그인 시도 중단');

  @override
  String toString() {
    return message;
  }
}
