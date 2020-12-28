import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

enum CountdownStatus {
  Active,
  Stopped,
  Finished,
}

CountdownController useCountdownController({
  TickerProvider vsync,
  List<Object> keys,
}) {
  vsync ??= useSingleTickerProvider(keys: keys);
  return use(_CountdownControllerHook(
    vsync: vsync,
    keys: keys,
  ));
}

class _CountdownControllerHook extends Hook<CountdownController> {
  final TickerProvider vsync;

  const _CountdownControllerHook({
    this.vsync,
    List<Object> keys,
  }) : super(keys: keys);

  @override
  HookState<CountdownController, Hook<CountdownController>> createState() =>
      _CountdownControllerHookState();
}

class _CountdownControllerHookState
    extends HookState<CountdownController, _CountdownControllerHook> {
  CountdownController _controller;

  @override
  void initHook() {
    super.initHook();
    _controller = CountdownController(vsync: hook.vsync);
  }

  @override
  void didUpdateHook(_CountdownControllerHook oldHook) {
    super.didUpdateHook(oldHook);
    if (hook.vsync != oldHook.vsync) {
      _controller.resync(hook.vsync);
    }
  }

  @override
  CountdownController build(BuildContext context) {
    return _controller;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class CountdownController with ChangeNotifier {
  CountdownStatus _status = CountdownStatus.Stopped;
  AnimationController _animCtrl;

  final TickerProvider vsync;

  CountdownController({
    @required this.vsync,
  }) : _animCtrl = AnimationController(vsync: vsync) {
    _animCtrl.addListener(() {
      notifyListeners();
    });
  }

  CountdownStatus get status => _status;

  Duration get duration => _animCtrl?.duration;

  Duration get passed => _animCtrl.duration * _animCtrl.value;

  Duration get remaining => _animCtrl.duration * (1 - _animCtrl.value);

  Animation<double> get animation => _animCtrl.view;

  void start(Duration duration) {
    stop();

    _animCtrl.duration = duration;
    _animCtrl.reset();
    _animCtrl.forward();
    _status = CountdownStatus.Active;

    notifyListeners();
  }

  void stop() {
    _animCtrl.stop();
    _status = CountdownStatus.Stopped;
    notifyListeners();
  }

  void resync(TickerProvider vsync) {
    _animCtrl.resync(vsync);
  }

  @override
  void dispose() {
    stop();
    _animCtrl.dispose();
    super.dispose();
  }
}

class DurationText extends StatelessWidget {
  final Duration duration;

  const DurationText({
    Key key,
    @required this.duration,
  })  : assert(duration != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final int totalSeconds = duration.inSeconds;
    final int minutesValue = totalSeconds ~/ 60;
    final int secondsValue = totalSeconds - minutesValue * 60;
    final minutes = minutesValue.toString().padLeft(2, '0');
    final seconds = secondsValue.toString().padLeft(2, '0');
    return Text('$minutes:$seconds');
  }
}

class CountdownBar extends HookWidget {
  final CountdownController controller;
  final double height;

  const CountdownBar({
    Key key,
    @required this.controller,
    this.height = 36.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller.status == CountdownStatus.Stopped) {
      return Container();
    }

    final theme = Theme.of(context);
    final color = theme.accentColor;
    final textColor = theme.colorScheme.onSecondary;

    return SizedBox(
      height: height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final widthAnimation = controller.animation.drive(
            Tween(begin: constraints.maxWidth, end: 0),
          );

          return AnimatedBuilder(
            animation: widthAnimation,
            builder: (context, child) {
              return Stack(
                children: [
                  Container(
                    width: widthAnimation.value,
                    color: color,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: DefaultTextStyle(
                      style: TextStyle(color: textColor),
                      child: DurationText(duration: controller.remaining),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
