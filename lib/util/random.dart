import 'dart:math';

final _random = Random();

double randomInRange(double min, double max) =>
    _random.nextDouble() * (max - min) + min;
