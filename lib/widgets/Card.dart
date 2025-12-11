
import 'package:flutter/material.dart';

Widget card(Widget child, {required Color color}) => Container(
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(10),
  ),
  child: child,
);