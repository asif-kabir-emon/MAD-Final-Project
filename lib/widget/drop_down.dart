import 'package:flutter/material.dart';

Widget customDropDown(List<String> items, String value, void onChange(val)) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    child: DropdownButton<String>(
      value: value,
      onChanged: (String? val) {
        onChange(val);
      },
      items: items.map((String val) {
        return DropdownMenuItem(
          value: val,
          child: Text(val),
        );
      }).toList(),
    ),
  );
}
