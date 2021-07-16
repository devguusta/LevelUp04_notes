import 'package:flutter/material.dart';

class NoteFormWidget extends StatelessWidget {
  final bool? isImportant;
  final int? number;
  final String? title;
  final String? description;
  final String hintText;
  final String initialValue;

  final TextEditingController? controller;
  final ValueChanged<bool>? onChangedImportant;
  final ValueChanged<int>? onChangedNumber;
  final ValueChanged<String>? onChangedTitle;
  final ValueChanged<String>? onChangedDescription;
  const NoteFormWidget({
    Key? key,
    this.isImportant,
    this.number,
    this.title,
    this.description,
    required this.hintText,
    required this.initialValue,
    this.controller,
    this.onChangedImportant,
    this.onChangedNumber,
    this.onChangedTitle,
    this.onChangedDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: "Roboto",
          fontWeight: FontWeight.w700,
          fontSize: 16.0,
          letterSpacing: 0.15,
          color: Colors.black.withOpacity(0.54),
        ),
        labelStyle: TextStyle(
          fontFamily: "Roboto",
          fontWeight: FontWeight.w700,
          fontSize: 18,
          letterSpacing: 0.15,
          color: Colors.black.withOpacity(0.54),
        ),
        border: InputBorder.none,
        errorBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
      ),
      validator: (value) =>
          value != null && value.isEmpty ? 'Preencha o campo' : null,
    );
  }
}
