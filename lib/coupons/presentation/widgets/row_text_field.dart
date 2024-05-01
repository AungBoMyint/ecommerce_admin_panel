import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class RowTextField extends StatelessWidget {
  const RowTextField({
    super.key,
    required this.label,
    required this.initialValue,
    required this.onChanged,
  });

  final String label;
  final String initialValue;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 200,
          child: Text(
            label,
          ),
        ),
        Gap(20),
        Expanded(
          child: SizedBox(
            height: 40,
            child: TextFormField(
              initialValue: initialValue,
              cursorHeight: 15,
              onChanged: onChanged,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.only(
                  left: 10,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
