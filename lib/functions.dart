import 'package:flutter/material.dart';

bool tryOrFalse(Function f) {
  try {
    return f();
  } catch (e) {
    return false;
  }
}

void hideKeyboard(context) {
  FocusScope.of(context).requestFocus(FocusNode());
}
