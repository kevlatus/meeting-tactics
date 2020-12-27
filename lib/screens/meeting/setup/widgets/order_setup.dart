import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meet/callbacks.dart';
import 'package:meet/models/models.dart';
import 'package:meet/screens/meeting/setup/widgets/step_layout.dart';
import 'package:meet/widgets/icon_text_toggle_buttons.dart';
import 'package:meet/widgets/page_stepper/page_stepper.dart';

import '../bloc.dart';

class OrderStrategySelector extends StatelessWidget {
  final OrderStrategy selected;
  final Callback<OrderStrategy> onChanged;

  const OrderStrategySelector({
    Key key,
    this.selected,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconTextToggleButtons(
      selected: selected,
      matcher: (v) => v.runtimeType == selected.runtimeType,
      items: [
        IconTextToggleButton(
          icon: Icon(Icons.linear_scale),
          text: 'Fixed',
          value: OrderStrategy.fixed(),
        ),
        IconTextToggleButton(
          icon: Icon(Icons.shuffle),
          text: 'Random',
          value: OrderStrategy.random(),
        ),
      ],
      onChanged: onChanged,
    );
  }
}

class OrderSetup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeetingSetupCubit, MeetingSetupState>(
      builder: (context, state) {
        final theme = Theme.of(context);

        return StepLayout(
          image: Image.asset('assets/images/ic-filter-people.png'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Who\'s next?',
                  style: theme.textTheme.headline6,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Center(
                  child: OrderStrategySelector(
                    selected: state.orderStrategy,
                    onChanged: (value) {
                      context
                          .bloc<MeetingSetupCubit>()
                          .changeOrderStrategy(value);
                    },
                  ),
                ),
              ),
              Center(child: StepperActions()),
            ],
          ),
        );
      },
    );
  }
}
