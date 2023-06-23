import 'package:flutter/material.dart';

class FormFieldWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const FormFieldWidget({
    required this.label,
    required this.controller,
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
                color: Theme.of(context).colorScheme.onSecondary),
          ),
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.onSecondary,
                width: 2.5,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(13.0),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.onBackground,
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
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
