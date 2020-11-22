import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class StepperState extends Equatable {
  final int activeIndex;
  final int itemCount;

  const StepperState({
    this.activeIndex = 0,
    @required this.itemCount,
  });

  int get boundedIndex =>
      activeIndex > 0 ? min(activeIndex, itemCount - 1) : max(activeIndex, 0);

  bool get hasNext => activeIndex + 1 < itemCount;

  bool get hasPrevious => boundedIndex > 0;

  bool get isComplete => activeIndex >= itemCount;

  StepperState previousStep() {
    return copyWith(activeIndex: activeIndex - 1);
  }

  StepperState nextStep() {
    return copyWith(activeIndex: activeIndex + 1);
  }

  StepperState copyWith({
    int activeIndex,
    int itemCount,
  }) =>
      StepperState(
        activeIndex: activeIndex ?? this.activeIndex,
        itemCount: itemCount ?? this.itemCount,
      );

  @override
  List<Object> get props => [activeIndex, isComplete, itemCount];
}

class StepperCubit extends Cubit<StepperState> {
  StepperCubit(
    int itemCount, {
    int activeIndex = 0,
  }) : super(StepperState(
          activeIndex: activeIndex,
          itemCount: itemCount,
        ));

  void previousStep() {
    emit(state.previousStep());
  }

  void nextStep() {
    emit(state.nextStep());
  }
}
