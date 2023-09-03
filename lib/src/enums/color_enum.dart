enum ForestColor {
  black("\x1B[30m"),
  red("\x1B[31m"),
  green("\x1B[32m"),
  yellow("\x1B[33m"),
  blue("\x1B[34m"),
  magenta("\x1B[35m"),
  cyan("\x1B[36m"),
  grey("\x1B[37m"),
  white("\x1B[38m");

  final String _value;

  String get value => _value;

  const ForestColor(this._value);
}