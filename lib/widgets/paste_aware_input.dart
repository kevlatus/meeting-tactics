import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:meet/callbacks.dart';

class PasteAwareTextInput extends HookWidget {
  final Callback<Iterable<String>> onSubmitted;
  final String labelText;

  const PasteAwareTextInput({
    this.labelText = '',
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final textCtrl = useTextEditingController();
    final textUpdate = useValueListenable(textCtrl);
    final focusNode = useFocusNode();
    final previousText = useState<String>(null);

    final canSubmit = textCtrl.text.trim().isNotEmpty;
    final previousTextLength = previousText.value?.length ?? 0;
    final charAmountChange = textCtrl.text.length - previousTextLength;

    void handleSubmit(Iterable<String> values) {
      if (values.where((element) => element.isNotEmpty).isEmpty) {
        return;
      }

      if (onSubmitted != null) {
        onSubmitted(values);
      }
      textCtrl.clear();
      focusNode.requestFocus();
    }

    void handlePaste() async {
      final clippedText = (await Clipboard.getData(Clipboard.kTextPlain)).text;

      final names = clippedText.split('\n');
      final filteredNames =
          names.map((it) => it.trim()).where((it) => it.isNotEmpty).toSet();

      if (filteredNames.isNotEmpty) {
        handleSubmit(filteredNames);
      }
    }

    void handleTextChange() async {
      if (charAmountChange > 5) {
        handlePaste();
      }
      previousText.value = textCtrl.text;
    }

    useEffect(() {
      handleTextChange();
      return null;
    }, [textUpdate]);

    return Row(
      children: [
        Expanded(
          child: TextField(
            autofocus: true,
            focusNode: focusNode,
            decoration: InputDecoration(labelText: labelText),
            controller: textCtrl,
            onSubmitted: (value) => handleSubmit([value]),
          ),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: canSubmit ? () => handleSubmit([textCtrl.text]) : null,
        ),
      ],
    );
  }
}
