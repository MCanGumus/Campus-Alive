import 'dart:ffi';

import 'package:destek_ve_sikayet_portali/Suggestion/Give/components/text_field_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  final bool isBold;

  const RoundedInputField({
    super.key,
    required this.hintText,
    required this.onChanged,
    required this.isBold,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        maxLines: null,
        style: isBold
            ? GoogleFonts.montserrat(fontWeight: FontWeight.bold)
            : GoogleFonts.montserrat(),
        onChanged: onChanged,
        decoration:
            InputDecoration(hintText: hintText, border: InputBorder.none),
      ),
    );
  }
}
