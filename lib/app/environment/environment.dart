import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:soon_sak/myApp.dart';



enum BuildType {
  development,
  production,
}

/// 2022.06.22 : Firebase 관련 설정 추가
/// TODO: APPsplyer --> sdk init을 여기에
class Environment {
  static Environment? _instance;

  factory Environment(BuildType buildType) =>
      _instance ??= Environment._internal(buildType);

  const Environment._internal(this._buildType);

  final BuildType _buildType;

  static BuildType get buildType => _instance!._buildType;

  static String get baseUrl => _instance!._buildType == BuildType.production
      ? dotenv.env['FIREBASE_KEY']!
      : dotenv.env['FIREBASE_KEY_DEV']!;

  void run() {
    runApp(const MyApp());
  }
}
