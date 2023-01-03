import 'package:flutter/material.dart';

var textInputDecoration = InputDecoration(
  hintText: '',
  filled: true,
  fillColor: Colors.white10,
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(color: Colors.transparent)
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.transparent),
    borderRadius: BorderRadius.circular(15)
  ),
  errorBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.red, width: 1),
    borderRadius: BorderRadius.circular(15)
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.red, width: 1),
    borderRadius: BorderRadius.circular(15)
  ),
);