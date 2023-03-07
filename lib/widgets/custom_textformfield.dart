import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final BuildContext context;
  final String label;
  final Function(String)? onChanged;
  final String? initialValue;
  const CustomTextFormField({
    Key? key,
    required this.context,
    required this.label,
    this.initialValue,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          SizedBox(
            width: 75,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Expanded(
            child: TextFormField(
              initialValue: initialValue ?? "",
              onChanged: onChanged,
              decoration: InputDecoration(
                labelText: label,
                isDense: true,
                contentPadding: const EdgeInsets.only(left: 10, bottom: 5),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
