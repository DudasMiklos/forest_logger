import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logging/logging.dart';
import 'services/auth_service.dart';
import 'enums/color_enum.dart';
import 'enums/weight_enum.dart';

class Forest {
  /// Stores the debug log enable state.
  static late bool _isDebugModeEnabled;

  /// Stores the profile log enable state.
  static late bool _isProfileModeEnabled;

  /// Stores the release log enable state.
  static late bool _isReleaseModeEnabled;

  /// Stores the timestamps enable state.
  static late bool _useTimestamps;

  /// Stores the separators enable state.
  static late bool _useSeparators;

  /// Stores the system log enable state.
  static late bool _showSystemLogs;

  /// Stores the auth token if successful auth.
  static String? _authToken;

  /// Stores the PID.
  static late String _pid;

  /// Stores the API key.
  static late String _apiKey;

  /// Returns whether debug mode logging is enabled.
  static bool get isDebugModeEnabled => _isDebugModeEnabled;

  /// Returns whether profile mode logging is enabled.
  static bool get isProfileModeEnabled => _isProfileModeEnabled;

  /// Returns whether release mode logging is enabled.
  static bool get isReleaseModeEnabled => _isReleaseModeEnabled;

  /// Returns the timestamp state.
  static bool get useTimestamps => _useTimestamps;

  /// Returns the separator state.
  static bool get useSeparators => _useSeparators;

  /// Returns the system log state.
  static bool get showSystemLogs => _showSystemLogs;

  /// Returns the auth token.
  static String? get authToken => _authToken;

  /// Initializes the library with optional parameters.
  ///
  /// [pid] and [apiKey] are required for authentication.
  /// [isDebugModeEnabled] enables debug logs (default: `true`).
  /// [isProfileModeEnabled] enables profile logs (default: `false`).
  /// [isReleaseModeEnabled] enables release logs (default: `false`).
  /// [useTimestamps] enables timestamps in logs (default: `false`).
  /// [useSeparators] enables top dotted separator in console (default: `false`).
  /// [showSystemLogs] enables system logs (default: `true`).
  static Future<void> init({
    required String pid,
    required String apiKey,
    bool isDebugModeEnabled = true,
    bool isProfileModeEnabled = false,
    bool isReleaseModeEnabled = false,
    bool useTimestamps = false,
    bool useSeparators = false,
    bool showSystemLogs = true,
  }) async {
    _isDebugModeEnabled = isDebugModeEnabled;
    _isProfileModeEnabled = isProfileModeEnabled;
    _isReleaseModeEnabled = isReleaseModeEnabled;
    _useTimestamps = useTimestamps;
    _useSeparators = useSeparators;
    _showSystemLogs = showSystemLogs;
    _pid = pid;
    _apiKey = apiKey;

    // Load environment variables
    await dotenv.load(fileName: '.env');

    // Initialize the AuthService and get the token
    try {
      final authService = AuthService();
      final token = await authService.login(_pid, _apiKey);
      if (token != null) {
        _authToken = token;
        debug('Authentication successful. Token acquired.');
      } else {
        error('Authentication failed. Token not received.');
      }
    } catch (e) {
      error('An error occurred during authentication: $e');
    }

    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((data) {
      if (_showSystemLogs) {
        systemLog(data.message);
      }
    });
  }

  /// Logs a critical message in red.
  static void critical(String text) {
    _writeLog(text: text, label: 'CRITICAL', color: ForestColor.red);
  }

  /// Logs an error message in red.
  static void error(String text) {
    _writeLog(text: text, label: 'ERROR', color: ForestColor.red);
  }

  /// Logs a success message in green.
  static void success(String text) {
    _writeLog(text: text, label: 'SUCCESS', color: ForestColor.green);
  }

  /// Logs a warning message in yellow.
  static void warning(String text) {
    _writeLog(text: text, label: 'WARNING', color: ForestColor.yellow);
  }

  /// Logs an info message in blue.
  static void info(String text) {
    _writeLog(text: text, label: 'INFO', color: ForestColor.blue);
  }

  /// Logs a debug message in magenta.
  static void debug(String text) {
    _writeLog(text: text, label: 'DEBUG', color: ForestColor.magenta);
  }

  /// Logs a todo message in cyan.
  static void todo(String text) {
    _writeLog(text: text, label: 'TODO', color: ForestColor.cyan);
  }

  /// Logs a system message in white.
  static void systemLog(String text) {
    _writeLog(text: text, label: 'SYSTEM LOG', color: ForestColor.white);
  }

  static void _writeLog({
    required String text,
    required String label,
    ForestColor color = ForestColor.blue,
  }) {
    if (!_isLoggingEnabled()) return;

    if(authToken == null) return;

    if (_useSeparators) {
      _printSeparator(color);
    }

    final timestamp = _useTimestamps ? ' [${DateTime.now()}]' : '';
    final formattedLabel = '[$label]$timestamp: ';

    if (Platform.isIOS || Platform.isMacOS) {
      // Color codes may not be supported.
      //ignore: avoid_print
      print(' $formattedLabel$text');
    } else {
      final coloredLabel =
          '${ForestWeight.bold.value}${color.value}$formattedLabel${ForestWeight.normal.value}${color.value}';
      final reset = ForestWeight.normal.value;
      //ignore: avoid_print
      print(' $coloredLabel$text$reset');
    }
  }

  static bool _isLoggingEnabled() {
    if (kDebugMode && _isDebugModeEnabled) return true;
    if (kProfileMode && _isProfileModeEnabled) return true;
    if (kReleaseMode && _isReleaseModeEnabled) return true;
    return false;
  }

  static void _printSeparator(ForestColor color) {
    const separatorLine =
        '------------------------------------------------------------------------------------------';
    if (Platform.isIOS || Platform.isMacOS) {
      //ignore: avoid_print
      print(separatorLine);
    } else {
      //ignore: avoid_print
      print(
          '${color.value}${ForestWeight.bold.value} $separatorLine${ForestWeight.normal.value}');
    }
  }
}
