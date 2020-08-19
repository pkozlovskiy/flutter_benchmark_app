import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'model/user.dart';

void main() {
  Future<List<User>> fetchUsers(
      List<User> Function(String jsonStr) parseUsers, String jsonStr) async {
    return parseUsers?.call(jsonStr);
  }

  runApp(App(fetchUsers));
}

void mainCompute() {
  Future<List<User>> fetchUsers(
      List<User> Function(String jsonStr) parseUsers, String jsonStr) async {
    return compute(parseUsers, jsonStr);
  }

  runApp(App(fetchUsers));
}
