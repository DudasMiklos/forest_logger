# Forest Logger
![build](https://img.shields.io/badge/build-fails-FF0000?style=flat) ![version](https://img.shields.io/badge/version-1.2.0-3887BE?style=flat)

## BUILD FAILING! USE v1.1.1!
### 1.2.x is currently in DEV stage, if you feel like testing it, or contribute to it contact me via github or email.

## Overview
Forest Logger is a comprehensive logging tool designed to facilitate easy and efficient logging in software applications. This document provides detailed information on how to use its various functionalities.

## Installation
Using Forest Logger as a Library

```bash
$ flutter pub add forest_logger
$ flutter pub get
```

## Features

- On Android/Windows/Linux devices it run in color mode, on iOS, macOS it runs in black-white mode
- Allows logging while in profile/release modes
- Created timestamps for log events


## Functions
### `init(options)`
Initializes the Forest Logger library with various logging configurations.

#### Parameters:
- `pid`: (string) {required} The PID of the application.
- `apiKey`: (string) {required} The API key for the application.
- `isDebugModeEnabled`: (bool, default `false`) Enables debug logs.
- `isProfileModeEnabled`: (bool, default `false`) Enables profile logs.
- `isReleaseModeEnabled`: (bool, default `false`) Enables release logs.
- `useTimestamps`: (bool, default `false`) Enables timestamps in logs.
- `useSeparators`: (bool, default `false`) Enables a dotted separator in the console logs.
- `showSystemLogs`: (bool, default `true`) Enables system logs.

#### Description:
This function sets up the logger with the specified configurations, allowing for tailored logging experiences in different modes (debug, profile, release). It includes options for timestamps and console separators for enhanced log readability.

#### Example:
```dart
Forest.init(
  pid: "8c96238b-e054-43bc-ad81-be03c02e11c9",
  apiKey: "dev-25f69d-e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
  isDebugModeEnabled: true,
  useTimestamps: true,
  useSeparators: true,
);
```

### `error(string) - and the others`
Initializes the Forest Logger library with various logging configurations.

#### Parameters:
- (string) The String to be logged.

| Method    | Description | Use Case | Log Level | Color   |
|-----------|-------------|----------|-----------|---------|
| critical  | Logs critical messages indicating serious failures. | Code breaking logs. | 50 | Red     |
| error     | Logs error messages. | When an error occurs, typically in a try-catch block. | 40 | Red     |
| success   | Logs success messages. | To log successful events. | 0 | Green   |
| warning   | Logs warning messages. | For warnings, e.g., non-nominal API responses. | 30 | Yellow  |
| info      | Logs informational messages. | For informational prints. | 20 | Blue    |
| debug     | Logs debug messages. | For debug prints. | 10 | Magenta |
| todo      | Logs todo messages. | For planned or todo texts. | 0 | Cyan    |
| systemLog | Logs system messages. | General purpose logging. | 0-50 | White   |

#### Example:
```dart
Forest.error("An error occurred in the application.");
```
#### Examples description:
The upper  line logs an error message in red to the console, typically used within a try-catch block.




## License

MIT
**Free Software, Hell Yeah!**



