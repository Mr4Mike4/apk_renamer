import 'package:fluent_ui/fluent_ui.dart';

class CheckBoxRow extends StatefulWidget {
  const CheckBoxRow({
    super.key,
    required this.text,
    required this.checkboxController,
  });

  final String text;
  final ValueNotifier<bool?> checkboxController;

  @override
  State<CheckBoxRow> createState() => _CheckBoxRowState();
}

class _CheckBoxRowState extends State<CheckBoxRow> {
  bool _checkboxValue = false;

  @override
  void initState() {
    super.initState();
    _checkboxValue = widget.checkboxController.value ?? false;
    widget.checkboxController.addListener(_handleControllerChanged);
  }

  @override
  void didUpdateWidget(CheckBoxRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.checkboxController.removeListener(_handleControllerChanged);
    widget.checkboxController.addListener(_handleControllerChanged);
  }

  @override
  void dispose() {
    widget.checkboxController.removeListener(_handleControllerChanged);
    super.dispose();
  }

  void _handleControllerChanged() {
    final value = widget.checkboxController.value;
    setState(() {
      _checkboxValue = value ?? false;
    });
  }

  void _didChange(bool? value) {
    if (value != null) {
      widget.checkboxController.value = value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Checkbox(
            checked: _checkboxValue,
            onChanged: _didChange,
          ),
        ),
        Text(widget.text),
      ],
    );
  }
}
