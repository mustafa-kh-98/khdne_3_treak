import 'dart:collection';

import 'dart:convert';

import 'package:flutter/foundation.dart';

class Log {
  static void logs({required String title, required String msg}) {
    if (kDebugMode) {
      print("-" * 30);
      print('TAG:: $title =======> $msg');
      print("-" * 30);
    }
  }

  static void loga({required String title, required var msg}) {
    if (kDebugMode) {
      final pattern = RegExp('.{1,800}');
      pattern.allMatches(msg).forEach(
            (match) => print(
              'TAG:: $title :: ${match.group(0)!}',
            ),
          );
    }
  }

  static void logi({required String title, required int msg}) {
    if (kDebugMode) {
      print('TAG:: $title :: $msg');
    }
  }

  static printWrapped({required String text}) {
    final pattern = RegExp('.{1,800}');
    if (kDebugMode) {
      pattern.allMatches(text).forEach(
            (match) => print(
              match.group(0),
            ),
          );
    }
  }

  static printPrettyMap({required Map mapData, required String title}) {
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
    final sortedData =
        SplayTreeMap<String, dynamic>.from(mapData, (a, b) => a.compareTo(b));
    String prettyPrint = encoder.convert(sortedData);
    if (kDebugMode) {
      print("TAG:: $prettyPrint =======> $title:: ");
    }
  }
}
