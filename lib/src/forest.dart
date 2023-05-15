import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
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

  static const LOG_LEVEL_CRITICAL = 0;
  static const LOG_LEVEL_ERROR = 1;
  static const LOG_LEVEL_SUCCESS = 2;
  static const LOG_LEVEL_WARNING = 3;
  static const LOG_LEVEL_INFO = 4;
  static const LOG_LEVEL_DEBUG = 5;
  static const LOG_LEVEL_NOTSET = 6;
  static const LOG_LEVEL_SYSTEM = 7;

  ///---
  /// critical Logs to console in black, use for code breaking logs, LOG_LEVEL: 50
  ///---
  static void critical(String text) {
    _createLog(text, logLevel: LOG_LEVEL_CRITICAL);
  }

  ///---
  /// error Logs to console in red, use for when a error accours tipically in a try - catch, LOG_LEVEL: 40
  ///---
  static void error(String text) {
    _createLog(text, logLevel: LOG_LEVEL_ERROR);
  }

  ///---
  /// success Logs to console in green, use for log success events, LOG_LEVEL: 0
  ///---
  static void success(String text) {
    _createLog(text, logLevel: LOG_LEVEL_SUCCESS);
  }

  ///---
  /// warning Logs to console in yellow, use when warning accours, example api response is not nominal, LOG_LEVEL: 30
  ///---
  static void warning(String text) {
    _createLog(text, logLevel: LOG_LEVEL_WARNING);
  }

  ///---
  /// info Logs to console in blue, use for info prints, LOG_LEVEL: 20
  ///---
  static void info(String text) {
    _createLog(text, logLevel: LOG_LEVEL_INFO);
  }

  ///---
  /// debug Logs to console in magenta, use for debug prints, LOG_LEVEL: 10
  ///---
  static void debug(String text) {
    _createLog(text, logLevel: LOG_LEVEL_DEBUG);
  }

  ///---
  /// notSet Logs to console in cyan, use for plan text, LOG_LEVEL: 0
  ///---
  static void notSet(String text) {
    _createLog(text, logLevel: LOG_LEVEL_NOTSET);
  }

  ///---
  /// systemLog Logs to console in white, LOG_LEVEL: 0 - 50
  ///---
  static void systemLog(String text) {
    _createLog(text, logLevel: LOG_LEVEL_SYSTEM);
  }

  static void _createLog(String text, {int logLevel = LOG_LEVEL_INFO}) {
    DateTime now = DateTime.now();
    String messageToLog =
        showDetailsInLog ? "${now.toString()} : ${text}" : text;
    ;

    switch (logLevel) {
      case LOG_LEVEL_CRITICAL:
        _createEvent('\x1B[30m$messageToLog\x1B[0m', name: 'CRITICAL');
        break;
      case LOG_LEVEL_ERROR:
        _createEvent('\x1B[31m$messageToLog\x1B[0m', name: 'ERROR');
        break;
      case LOG_LEVEL_SUCCESS:
        _createEvent('\x1B[32m$messageToLog\x1B[0m', name: 'SUCCESS');
        break;
      case LOG_LEVEL_WARNING:
        _createEvent('\x1B[33m$messageToLog\x1B[0m', name: 'WARNING');
        break;
      case LOG_LEVEL_INFO:
        _createEvent('\x1B[34m$messageToLog\x1B[0m', name: 'INFO');
        break;
      case LOG_LEVEL_DEBUG:
        _createEvent('\x1B[35m$messageToLog\x1B[0m', name: 'DEBUG');
        break;
      case LOG_LEVEL_NOTSET:
        _createEvent('\x1B[36m$messageToLog\x1B[0m', name: 'NOTSET');
        break;
      case LOG_LEVEL_SYSTEM:
        _createEvent('\x1B[37m$messageToLog\x1B[0m', name: 'SYSTEM');
        break;
      default:
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
