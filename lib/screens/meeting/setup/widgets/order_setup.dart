import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meet/callbacks.dart';
import 'package:meet/models/models.dart';
import 'package:meet/screens/meeting/setup/widgets/step_layout.dart';
import 'package:meet/widgets/page_stepper/page_stepper.dart';

import '../bloc.dart';

class OrderStrategySelector extends StatelessWidget {
  final OrderStrategy selected;
  final Callback<OrderStrategy> onChanged;

  Widget _buildItem(BuildContext context, Widget icon, Widget text) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: 96),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: icon,
          ),
          text,
        ],
      ),
    );
  }

  const OrderStrategySelector({
    Key key,
    this.selected,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      borderRadius: BorderRadius.circular(4),
      isSelected: [
        selected is FixedOrderStrategy,
        selected is RandomOrderStrategy,
      ],
      children: [
        _buildItem(
          context,
          Icon(Icons.linear_scale),
          Text('Fixed'),
        ),
        _buildItem(
          context,
          Icon(Icons.shuffle),
          Text('Random'),
        ),
      ],
      onPressed: (int index) {
        if (onChanged != null) {
          onChanged(
            index == 0 ? OrderStrategy.fixed() : OrderStrategy.random(),
          );
        }
      },
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
