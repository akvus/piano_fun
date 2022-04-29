extension IntExtension on int {
  bool isBitSet(int bit) => (this & (1 << bit)) != 0;
}
