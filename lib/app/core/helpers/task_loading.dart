import 'package:flutter/material.dart';

class TaskLoading {
  static Widget button() {
    return const SizedBox(
      height: 28,
      width: 28,
      child: CircularProgressIndicator(
        color: Colors.white,
        strokeWidth: 3,
      ),
    );
  }
}
