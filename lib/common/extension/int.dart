extension IntExtension on int {
  bool checkBit(int bit) => (this & (1 << bit)) != 0;
}
