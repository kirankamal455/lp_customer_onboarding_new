import 'package:flutter/material.dart';

class CustomTextStyle {
  static TextStyle titleStyle(Color textColor) {
    return TextStyle(
        fontSize: 18, fontWeight: FontWeight.bold, color: textColor);
  }

  static TextStyle welcomeTitleStyle(Color textColor) {
    return TextStyle(
        fontSize: 17, fontWeight: FontWeight.bold, color: textColor);
  }

  static TextStyle welcomeScreenStyle(Color textColor) {
    return TextStyle(fontSize: 18, color: textColor);
  }

  static TextStyle subtitleStyle(Color textColor) {
    return TextStyle(fontSize: 15, color: textColor);
  }

  static TextStyle subtitle2Style(Color textColor) {
    return TextStyle(fontSize: 18, color: textColor);
  }

  static TextStyle buttonStyle(Color textColor) {
    return TextStyle(fontSize: 15, color: textColor);
  }

  static TextStyle cardtitleStyle(Color textColor) {
    return TextStyle(
        fontSize: 16, fontWeight: FontWeight.bold, color: textColor);
  }

  static TextStyle cardsubtitleStyle(Color textColor) {
    return TextStyle(color: textColor);
  }

  static TextStyle addfundtitle() {
    return TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[500]);
  }

  static TextStyle addfundtitle1() {
    return const TextStyle(fontWeight: FontWeight.bold, fontSize: 15);
  }

  static TextStyle addfundtitle2() {
    return TextStyle(fontSize: 14, color: Colors.grey[500]);
  }

  static TextStyle trsubtittle() {
    return const TextStyle(fontSize: 12, fontWeight: FontWeight.w700);
  }

  static TextStyle trsubtittle1() {
    return const TextStyle(fontSize: 12);
  }

  static TextStyle modalTitleStyle() {
    return const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  }

  static TextStyle retrsubtittle(Color textColor) {
    return TextStyle(fontSize: 12, color: textColor);
  }

  static TextStyle cardsubtittle() {
    return const TextStyle(fontSize: 14, fontWeight: FontWeight.w700);
  }

  static TextStyle cardsubtittle1() {
    return const TextStyle(
        color: Colors.black,
        fontFamily: 'MavenPro',
        fontWeight: FontWeight.w500,
        fontSize: 12);
  }
}
