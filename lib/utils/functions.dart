import 'dart:math';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

Color randomColor() => Color.fromARGB(255, Random().nextInt(255), Random().nextInt(255), Random().nextInt(255));

String parseDateTime(DateTime date, String regex) {
  return Jiffy(date).format(regex);
}

DateTime parseDateString(String date, String regex) {
  return Jiffy(date, regex).dateTime;//.utc();
}

int differenceBWDateString(String date1, String date2, String regex) {
  return Jiffy(date1, regex).diff(Jiffy(date2, regex));
}