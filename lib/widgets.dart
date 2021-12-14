import 'package:flutter/material.dart';

Widget loader() {
  return const Material(
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}

Widget fetchError(String error) {
  return Center(
    child: Text(error),
  );
}
