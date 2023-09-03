enum ForestWeight {
  bold("\x1B[1m"),
  normal("\x1B[0m");

  final String _value;

  String get value => _value;

  const ForestWeight(this._value);
}