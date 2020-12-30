import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meet/callbacks.dart';
import 'package:meet/models/models.dart';
import 'package:meet/screens/meeting/setup/widgets/step_layout.dart';
import 'package:meet/widgets/icon_text_toggle_buttons.dart';
import 'package:meet/widgets/page_stepper/page_stepper.dart';
import 'package:meet/widgets/svg_or_png_image.dart';

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
          image: SvgOrPngImage('assets/images/img-undraw-filter.png'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Who\'s next?',
                style: theme.textTheme.headline6,
              ),
              SizedBox(height: 16),
              Text(
                'Define the order in which participants will give their '
                'updates. Use random for best effect.',
              ),
              SizedBox(height: 16),
              Center(
                child: OrderStrategySelector(
                  selected: state.orderStrategy,
                  onChanged: (value) {
                    context
                        .bloc<MeetingSetupCubit>()
                        .changeOrderStrategy(value);
                  },
                ),
              ),
              SizedBox(height: 16),
              Center(child: StepperActions()),
            ],
          ),
        );
      },
    );
  }
}
