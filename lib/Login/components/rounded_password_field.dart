import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  final String text;
  final ValueChanged<String> onChanged;
  const RoundedPasswordField(
      {super.key, required this.onChanged, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        decoration: InputDecoration(
            hintText: text,
            icon: Icon(Icons.lock, color: kProblemBackgroundColor),
            suffixIcon: Icon(Icons.visibility, color: kEventColor),
            border: InputBorder.none),
      ),
    );
  }
}
