import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit.dart';

class PageStepper extends StatelessWidget {
  final List<Widget> steps;
  final VoidCallback onCompleted;

  const PageStepper({
    Key key,
    @required this.steps,
    this.onCompleted,
  })  : assert(steps != null && steps.length > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StepperCubit>(
      create: (_) => StepperCubit(steps.length),
      child: _PageStepperView(
        steps: steps,
        onCompleted: onCompleted,
      ),
    );
  }
}

class _PageStepperView extends StatelessWidget {
  final List<Widget> steps;
  final VoidCallback onCompleted;

  const _PageStepperView({
    Key key,
    @required this.steps,
    this.onCompleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<StepperCubit, StepperState>(
      listener: (context, state) {
        if (onCompleted != null) {
          onCompleted();
        }
      },
      listenWhen: (previous, current) => current.isComplete ?? false,
      child: BlocBuilder<StepperCubit, StepperState>(
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async {
              if (state.hasPrevious) {
                context.bloc<StepperCubit>().previousStep();
                return false;
              } else {
                return true;
              }
            },
            child: steps[state.boundedIndex],
          );
        },
      ),
    );
  }
}
