import 'package:expense_tracker/core/theme/const_color.dart';
import 'package:flutter/material.dart';

class CommonWidget {
  textFormFieldWidget({
    TextInputType textInputType = TextInputType.text,
    int minLines = 1,
    int maxlines = 1,
    required BuildContext context,
    required String labelText,
    required TextEditingController controller,
    required bool secure,
    bool visible = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: TextFormField(
          validator: (value) {
            if (value == null || value == '') {
              return '$labelText invalid';
            } else {
              return null;
            }
          },
          // autofocus: true,
          minLines: minLines,
          maxLines: maxlines,
          keyboardType: textInputType,
          obscureText: visible,
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: ConstColor.backgroundColor,
            filled: true,
            labelText: labelText,
            labelStyle: const TextStyle(
                color: Color.fromARGB(255, 111, 111, 111), fontSize: 16),
          ),
          style: TextStyle(
            color: MediaQuery.of(context).platformBrightness == Brightness.light
                ? Colors.black
                : Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
