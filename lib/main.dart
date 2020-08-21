import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'model/user.dart';

void main() {
  mainReusedIsolate();
}

void mainImpl(
    Future<List<User>> Function(
            List<User> Function(String jsonStr) parseUsers, String jsonStr)
        fetchUsers) {
  runApp(App(fetchUsers));
}

void mainWithOutIsolate() {
  mainImpl(
      (List<User> Function(String jsonStr) parseUsers, String jsonStr) async =>
          parseUsers?.call(jsonStr));
}

void mainIsolate() {
  mainImpl(
      (List<User> Function(String jsonStr) parseUsers, String jsonStr) async =>
          compute(parseUsers, jsonStr,debugLabel:'benchmark'));
}

void mainReusedIsolate() {
  parseJson('[]');
  mainImpl(
      (List<User> Function(String jsonStr) parseUsers, String jsonStr) async {
    return parseJson(jsonStr);
  });
}

SendPort sendPort;

Future<List<User>> parseJson(String jsonToParse) {
  return initParsing().then((value) {
    final receivePort = ReceivePort();
    value.send(JsonIsolateMessage(receivePort.sendPort, jsonToParse));
    return receivePort.first.then((value) => value as List<User>) ;
  });
}

Future<SendPort> initParsing() => sendPort != null
    ? Future<SendPort>.value(sendPort)
    : Future.value().then((value) {
        {
          final receivePort = ReceivePort();
          return Isolate.spawn(
            isolateCallback,
            receivePort.sendPort,
            debugName: 'benchmark'
          ).then((value) => receivePort.first).then((value) {
            sendPort = value;
            return value;
          });
        }
      });

void isolateCallback(SendPort sendPort) {
  final receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort);

  receivePort.listen((dynamic message) {
    final incomingMessage = message as JsonIsolateMessage;
    List<User> decode = _parseUsers(incomingMessage.text);
    incomingMessage.sender.send(decode);
  });
}

List<User> _parseUsers(String jsonStr) {
  final parsed = json.decode(jsonStr).cast<Map<String, dynamic>>();
  return parsed.map<User>((json) => User.fromJson(json)).toList();
}

class JsonIsolateMessage {
  final SendPort sender;
  final String text;

  JsonIsolateMessage(this.sender, this.text);
}
