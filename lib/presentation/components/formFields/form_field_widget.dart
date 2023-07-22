import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormFieldWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final int? maxLines;
  final bool typeNumber;

  const FormFieldWidget({
    required this.label,
    required this.controller,
    this.typeNumber = false,
    this.maxLines,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(2, 0, 0, 5),
          child: Text(
            label,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary),
          ),
        ),
        TextField(
          keyboardType: typeNumber ? TextInputType.number : TextInputType.text,
          inputFormatters: typeNumber
              ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
              : null,
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.outlineVariant,
                width: 2.5,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(13.0),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.outline,
                width: 2.5,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(13.0),
              ),
            ),
          ),
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
