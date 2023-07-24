import 'dart:developer' as developer;

import 'package:flutter/material.dart';

class Debug {
  static final Debug _debug = Debug._internal();

  factory Debug() {
    return _debug;
  }

  Debug._internal();

  static var enabled = false;

  static void log(dynamic message) {
    if (enabled) {
      debugPrint('[DEBUG] $message');
    }
  }

  static void d(dynamic message, {String tag = 'DEBUG'}) {
    if (enabled) {
      developer.log(message.toString(), name: tag);
    }
  }
}