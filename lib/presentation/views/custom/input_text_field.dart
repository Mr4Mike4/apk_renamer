import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    Key? key,
    required this.labelText,
    this.controller,
    this.focusNode,
    this.readOnly = false,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.sentences,
    this.obscureText = false,
    this.inputFormatters,
    this.maxLines = 1,
  }) : super(key: key);

  final String labelText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  // final String? initialValue;
  final bool readOnly;
  final TextInputType? keyboardType;
  // final FormFieldValidator<String>? validator;
  final TextCapitalization textCapitalization;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLines;

  // final InputDecoration? decoration;

  // final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return InfoLabel(
      label: labelText,
      child: TextBox(
        controller: controller,
        readOnly: readOnly,
        focusNode: readOnly ? null : focusNode,
        keyboardType: keyboardType,
        textCapitalization: textCapitalization,
        obscureText: obscureText,
        inputFormatters: inputFormatters,
        maxLines: maxLines,
      ),
    );
  }
}
