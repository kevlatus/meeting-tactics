import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'cubit.dart';

typedef BoolCallback = bool Function();

abstract class StepperActions extends StatelessWidget {
  BoolCallback get canContinue;

  BoolCallback get canPrevious;

  factory StepperActions({
    Key key,
    BoolCallback canContinue,
    BoolCallback canPrevious,
  }) = _SimpleStepperActions;

  factory StepperActions.animated({
    Key key,
    BoolCallback canContinue,
    BoolCallback canPrevious,
  }) = _AnimatedStepperActions;
}

class _SimpleStepperActions extends StatelessWidget implements StepperActions {
  final BoolCallback canContinue;
  final BoolCallback canPrevious;

  const _SimpleStepperActions({
    Key key,
    this.canContinue,
    this.canPrevious,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stepperCubit = context.bloc<StepperCubit>();

    final previousButton = Padding(
      padding: const EdgeInsets.only(right: 8),
      child: TextButton(
        onPressed: () {
          if (canPrevious == null || canPrevious()) {
            stepperCubit.previousStep();
          }
        },
        child: Text('PREVIOUS'),
      ),
    );

    final continueButton = ElevatedButton(
      onPressed: () {
        if (canContinue == null || canContinue()) {
          stepperCubit.nextStep();
        }
      },
      child: Text('CONTINUE'),
    );

    return BlocBuilder<StepperCubit, StepperState>(
      builder: (context, state) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (state.hasPrevious) previousButton,
            continueButton,
          ],
        );
      },
    );
  }
}

class _AnimatedStepperActions extends HookWidget implements StepperActions {
  final BoolCallback canContinue;
  final BoolCallback canPrevious;

  const _AnimatedStepperActions({
    Key key,
    this.canContinue,
    this.canPrevious,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ticker = useSingleTickerProvider();

    return AnimatedSize(
      vsync: ticker,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
      child: Container(
        height: canContinue() ? null : 0,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: StepperActions(
            canContinue: canContinue,
            canPrevious: canPrevious,
          ),
        ),
      ),
    );
  }
}
