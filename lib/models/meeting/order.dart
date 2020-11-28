import 'package:flutter/foundation.dart';

abstract class OrderStrategy with ChangeNotifier {
  int get selected;

  int get itemCount;

  bool get isStarted;

  bool get isDone;

  void next();

  void previous();

  void reset();
}

class FixedOrderStrategy with ChangeNotifier implements OrderStrategy {
  int _currentIndex = -1;

  @override
  final int itemCount;

  FixedOrderStrategy(this.itemCount);

  @override
  int get selected => _currentIndex;

  @override
  bool get isStarted => _currentIndex != -1;

  @override
  bool get isDone => _currentIndex + 1 == itemCount;

  @override
  void next() {
    if (isDone) {
      throw Exception('No more items left');
    }
    _currentIndex++;
    notifyListeners();
  }

  @override
  void previous() {
    if (!isStarted) {
      throw Exception('No previous item available');
    }
    _currentIndex--;
    notifyListeners();
  }

  @override
  void reset() {
    _currentIndex = -1;
    notifyListeners();
  }
}
