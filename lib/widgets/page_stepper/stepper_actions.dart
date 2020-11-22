import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit.dart';

typedef BoolCallback = bool Function();

class StepperActions extends StatelessWidget {
  final BoolCallback onContinue;
  final BoolCallback onPrevious;

  Widget _buildPreviousButton(BuildContext context, StepperState state) {
    if (state.hasPrevious) {
      return Padding(
        padding: const EdgeInsets.only(right: 8),
        child: TextButton(
          onPressed: () {
            if (onPrevious == null || onPrevious()) {
              context.bloc<StepperCubit>().previousStep();
            }
          },
          child: Text('PREVIOUS'),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _buildContinueButton(BuildContext context, StepperState state) {
    return OutlineButton(
      onPressed: () {
        if (onContinue == null || onContinue()) {
          context.bloc<StepperCubit>().nextStep();
        }
      },
      child: Text(state.hasNext ? 'CONTINUE' : 'FINISH'),
    );
  }

  const StepperActions({
    Key key,
    this.onContinue,
    this.onPrevious,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StepperCubit, StepperState>(
      builder: (context, state) {
        return Row(
          children: [
            Spacer(),
            _buildPreviousButton(context, state),
            _buildContinueButton(context, state),
          ],
        );
      },
    );
  }
}
