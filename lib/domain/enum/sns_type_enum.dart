import 'package:flutter/material.dart';

enum Sns {
  google(
      name: '구글', 
      originString: 'google',
      logoPath: 'google_logo.svg',
      textColor: Colors.black,
      bgColor: Colors.white),
  apple(
      name: 'Apple',
      originString: 'apple',
      logoPath: 'apple_logo.svg',
      textColor: Colors.white,
      bgColor: Colors.black);

  final String name;
  final String originString;
  final String logoPath;
  final Color bgColor;
  final Color textColor;

  const Sns(
      {required this.name,
      required this.logoPath,
      required this.textColor,
      required this.bgColor,
      required this.originString});

  factory Sns.fromOriginString(String originId) {
    switch (originId) {
      case 'apple':
        return Sns.apple;
      case 'google':
        return Sns.google;
      default:
        throw Exception('Sns Enum : enum not found');
    }
  }
}
