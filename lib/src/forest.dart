import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:forest_logger/src/log_levels.dart';
import 'package:logging/logging.dart';

class Forest {
  ///Stores the debug log enable state
  static late bool _isDebugModeEnabled;

  ///Stores the profile log enable state
  static late bool _isProfileModeEnabled;

  ///Stores the release log enable state
  static late bool _isReleaseModeEnabled;

  ///Stores the release log enable state
  static late bool _showDetailsinLog;

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

  /// Returns the hostname
  static bool get showDetailsInLog {
    return _showDetailsinLog;
  }

  /// Initalizes the Library
  /// for input you must provide:
  /// - [String] hostname         -> for example https://example.com
  /// - [String] versionPath      -> for example /api/translation/version
  /// - [String] translationsPath -> for example /api/translation/translations
  /// Optional parameters:
  /// - [List<Locale>] supportedLocales   -> defaults to: [Locale('hu')]
  /// - [Map<String, String>?] apiHeaders -> usage: set custom api headers for example auth Token,  defaults to: null
  static void init({
    bool isDebugModeEnabled = true,
    bool isProfileModeEnabled = false,
    bool isReleaseModeEnabled = false,
    bool showDetailsinLog = false,
  }) {
    _isDebugModeEnabled = isDebugModeEnabled;
    _isProfileModeEnabled = isProfileModeEnabled;
    _isReleaseModeEnabled = isReleaseModeEnabled;
    _showDetailsinLog = showDetailsinLog;

    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen(
      (data) {
        systemLog(data.message);
      },
    );
  }

  ///---
  /// critical Logs to console in black, use for code breaking logs, LOG_LEVEL: 50
  ///---
  static void critical(String text) {
    _createLog(text, logLevel: LogLevel.logLevelCritical);
  }

  ///---
  /// error Logs to console in red, use for when a error accours tipically in a try - catch, LOG_LEVEL: 40
  ///---
  static void error(String text) {
    _createLog(text, logLevel: LogLevel.logLevelError);
  }

  ///---
  /// success Logs to console in green, use for log success events, LOG_LEVEL: 0
  ///---
  static void success(String text) {
    _createLog(text, logLevel: LogLevel.logLevelSuccess);
  }

  ///---
  /// warning Logs to console in yellow, use when warning accours, example api response is not nominal, LOG_LEVEL: 30
  ///---
  static void warning(String text) {
    _createLog(text, logLevel: LogLevel.logLevelWarning);
  }

  ///---
  /// info Logs to console in blue, use for info prints, LOG_LEVEL: 20
  ///---
  static void info(String text) {
    _createLog(text, logLevel: LogLevel.logLevelInfo);
  }

  ///---
  /// debug Logs to console in magenta, use for debug prints, LOG_LEVEL: 10
  ///---
  static void debug(String text) {
    _createLog(text, logLevel: LogLevel.logLevelDebug);
  }

  ///---
  /// notSet Logs to console in cyan, use for plan text, LOG_LEVEL: 0
  ///---
  static void notSet(String text) {
    _createLog(text, logLevel: LogLevel.logLevelNotset);
  }

  ///---
  /// systemLog Logs to console in white, LOG_LEVEL: 0 - 50
  ///---
  static void systemLog(String text) {
    _createLog(text, logLevel: LogLevel.logLevelSystem);
  }

  static void _createLog(String text,
      {LogLevel logLevel = LogLevel.logLevelInfo}) {
    DateTime now = DateTime.now();
    String messageToLog = showDetailsInLog ? "${now.toString()} : $text" : text;

    switch (logLevel) {
      case LogLevel.logLevelCritical:
        _createEvent('\x1B[30m$messageToLog\x1B[0m', name: 'CRITICAL');
        break;
      case LogLevel.logLevelError:
        _createEvent('\x1B[31m$messageToLog\x1B[0m', name: 'ERROR');
        break;
      case LogLevel.logLevelSuccess:
        _createEvent('\x1B[32m$messageToLog\x1B[0m', name: 'SUCCESS');
        break;
      case LogLevel.logLevelWarning:
        _createEvent('\x1B[33m$messageToLog\x1B[0m', name: 'WARNING');
        break;
      case LogLevel.logLevelInfo:
        _createEvent('\x1B[34m$messageToLog\x1B[0m', name: 'INFO');
        break;
      case LogLevel.logLevelDebug:
        _createEvent('\x1B[35m$messageToLog\x1B[0m', name: 'DEBUG');
        break;
      case LogLevel.logLevelNotset:
        _createEvent('\x1B[36m$messageToLog\x1B[0m', name: 'NOTSET');
        break;
      case LogLevel.logLevelSystem:
        _createEvent('\x1B[37m$messageToLog\x1B[0m', name: 'SYSTEM');
        break;
      default:
        _createEvent('\x1B[34m$messageToLog\x1B[0m', name: 'INFO');
        break;
    }
  }

  static void _createEvent(String text, {String name = 'INFO'}) {
    if (kDebugMode && isDebugModeEnabled) {
      developer.log(
        text,
        name: name,
      );
    }
    if (kProfileMode && isProfileModeEnabled) {
      developer.log(
        text,
        name: name,
      );
    }
    if (kReleaseMode && isReleaseModeEnabled) {
      developer.log(
        text,
        name: name,
      );
    }
  }
}
