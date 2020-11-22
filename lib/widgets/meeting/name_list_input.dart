import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef StringsCallback = void Function(Iterable<String>);

class NameListInput extends StatefulWidget {
  final StringsCallback onSubmitted;

  NameListInput({this.onSubmitted});

  @override
  _NameListInputState createState() => _NameListInputState();
}

class _NameListInputState extends State<NameListInput> {
  final TextEditingController _controller = TextEditingController();
  FocusNode _focusNode;
  String _previousValue;
  bool _canSubmit = false;

  bool get _isUpdateMoreThanOneChar {
    return (_controller.text.length - (_previousValue?.length ?? 0)) > 1;
  }

  Future<void> _onSubmitted(Iterable<String> value) async {
    if (widget.onSubmitted != null) {
      widget.onSubmitted(value);
    }

    setState(() {
      _controller.clear();
    });
    _focusNode.requestFocus();
  }

  void _onTextChanged() async {
    final text = _isUpdateMoreThanOneChar
        ? (await Clipboard.getData(Clipboard.kTextPlain)).text
        : _controller.text;

    setState(() {
      _canSubmit = text.trim().isNotEmpty;
    });

    if (text.contains('\n')) {
      final names = text.split('\n');
      final filteredNames =
          names.map((it) => it.trim()).where((it) => it.isNotEmpty).toSet();

      if (filteredNames.isNotEmpty) {
        this._onSubmitted(filteredNames);
      }
    }

    _previousValue = text;
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            autofocus: true,
            focusNode: _focusNode,
            decoration: InputDecoration(labelText: 'Participant\'s Name'),
            controller: _controller,
            onSubmitted: (value) => _onSubmitted([value]),
          ),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: _canSubmit ? () => _onSubmitted([_controller.text]) : null,
        ),
      ],
    );
  }
}
