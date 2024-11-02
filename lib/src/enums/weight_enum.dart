enum ForestWeight {
  bold("\x1B[1m"),
  normal("\x1B[0m");

  final String value;

  const ForestWeight(this.value);
}