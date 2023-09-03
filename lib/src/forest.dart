import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import 'enums/color_enum.dart';
import 'enums/weight_enum.dart';

class Forest {

  ///Stores the debug log enable state
  static late bool _isDebugModeEnabled;

  ///Stores the profile log enable state
  static late bool _isProfileModeEnabled;

  ///Stores the release log enable state
  static late bool _isReleaseModeEnabled;

  ///Stores the time stamps enable state
  static late bool _useTimestamps;

  ///Stores the time stamps enable state
  static late bool _useSeparators;

  /// Returns the hostname
  static bool get isDebugModeEnabled {
    return _isDebugModeEnabled;
  }

  /// Returns the hostname
  static bool get isProfileModeEnabled {
    return _isProfileModeEnabled;
  }

  /// Returns the hostname
  static bool get isReleaseModeEnabled {
    return _isReleaseModeEnabled;
  }

  /// Returns the timestamp state
  static bool get useTimestamps {
    return _useTimestamps;
  }

  /// Returns the separator state
  static bool get useSeparators {
    return _useSeparators;
  }

  /// Initializes the Library
  /// Optional parameters:
  /// [isDebugModeEnabled] -> defaults to: `false` -> enables debug logs
  /// [isProfileModeEnabled] -> defaults to: `false` -> enables profile logs
  /// [isReleaseModeEnabled] -> defaults to: `false` -> enables release logs
  /// [useTimestamps] -> defaults to: `false` -> enables timestamps in logs
  /// [useSeparators] -> defaults to: `false` -> enables top dotted separator in console
  static void init({
    bool isDebugModeEnabled = true,
    bool isProfileModeEnabled = false,
    bool isReleaseModeEnabled = false,
    bool useTimestamps = false,
    bool useSeparators = false,
  }) {
    _isDebugModeEnabled = isDebugModeEnabled;
    _isProfileModeEnabled = isProfileModeEnabled;
    _isReleaseModeEnabled = isReleaseModeEnabled;
    _useTimestamps = useTimestamps;
    _useSeparators = useSeparators;

    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen(
          (data) {
        systemLog(data.message);
      },
    );
  }

  ///---
  /// critical Logs to console in red, use for code breaking logs, LOG_LEVEL: 50
  ///---
  static void critical(String text) {
    _writeLog(text: text, label: "CRITICAL", color: ForestColor.red);
  }

  ///---
  /// error Logs to console in red, use for when a error accours tipically in a try - catch, LOG_LEVEL: 40
  ///---
  static void error(String text) {
    _writeLog(text: text, label: "ERROR", color: ForestColor.red);
  }

  ///---
  /// success Logs to console in green, use for log success events, LOG_LEVEL: 0
  ///---
  static void success(String text) {
    _writeLog(text: text, label: "SUCCESS", color: ForestColor.green);
  }

  ///---
  /// warning Logs to console in yellow, use when warning accours, example api response is not nominal, LOG_LEVEL: 30
  ///---
  static void warning(String text) {
    _writeLog(text: text, label: "WARNING", color: ForestColor.yellow);
  }

  ///---
  /// info Logs to console in blue, use for info prints, LOG_LEVEL: 20
  ///---
  static void info(String text) {
    _writeLog(text: text, label: "INFO", color: ForestColor.blue);
  }

  ///---
  /// debug Logs to console in magenta, use for debug prints, LOG_LEVEL: 10
  ///---
  static void debug(String text) {
    _writeLog(text: text, label: "DEBUG", color: ForestColor.magenta);
  }

  ///---
  /// "todo" not set Logs to console in cyan, use for plan text or todo texts, LOG_LEVEL: 0
  ///---
  static void todo(String text) {
    _writeLog(text: text, label: "TODO", color: ForestColor.cyan);
  }

  ///---
  /// systemLog Logs to console in white, LOG_LEVEL: 0 - 50
  ///---
  static void systemLog(String text) {
    _writeLog(text: text, label: "SYSTEM LOG", color: ForestColor.white);
  }

  static void _writeLog({required String text, required String label, ForestColor color  = ForestColor.blue,}) {
    if(useSeparators){
      //ignore: avoid_print
      print('${color.value}${ForestWeight.bold.value} ------------------------------------------------------------------------------------------');
    }
    if (kDebugMode && isDebugModeEnabled) {
      if(useTimestamps){
        DateTime now = DateTime.now();
        //ignore: avoid_print
        print(
            ' ${color.value}${ForestWeight.bold.value}[$label] [${now.toString()}]:${ForestWeight.normal.value}${color.value} $text${ForestWeight.normal.value}');
      }else{
        //ignore: avoid_print
        print(
            ' ${color.value}${ForestWeight.bold.value}[$label]:${ForestWeight.normal.value}${color.value} $text${ForestWeight.normal.value}');
      }
    }    else if (kProfileMode && isProfileModeEnabled) {
      if(useTimestamps){
        DateTime now = DateTime.now();
        //ignore: avoid_print
        print(
            ' ${color.value}${ForestWeight.bold.value}[$label] [${now.toString()}]:${ForestWeight.normal.value}${color.value} $text${ForestWeight.normal.value}');
      }else{
        //ignore: avoid_print
        print(
            ' ${color.value}${ForestWeight.bold.value}[$label]:${ForestWeight.normal.value}${color.value} $text${ForestWeight.normal.value}');
      }
    }
    else if (kReleaseMode && isReleaseModeEnabled) {
      if(useTimestamps){
        DateTime now = DateTime.now();
        //ignore: avoid_print
        print(
            ' ${color.value}${ForestWeight.bold.value}[$label] [${now.toString()}]:${ForestWeight.normal.value}${color.value} $text${ForestWeight.normal.value}');
      }else{
        //ignore: avoid_print
        print(
            ' ${color.value}${ForestWeight.bold.value}[$label]:${ForestWeight.normal.value}${color.value} $text${ForestWeight.normal.value}');
      }
    }
  }
}
