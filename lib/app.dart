import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_benchmark_app/model/user.dart';

class App extends StatelessWidget {
  App(this.fetchUsers);

  final Future<List<User>> Function(
          List<User> Function(String jsonStr) parseUsers, String jsonStr)
      fetchUsers;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(fetchUsers),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage(
    this.fetchUsers, {
    Key key,
  }) : super(key: key);

  final Future<List<User>> Function(
          List<User> Function(String jsonStr) parseUsers, String jsonStr)
      fetchUsers;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<User> _users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Benchmark'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RaisedButton(
                  child: Text('Load 10'),
                  onPressed: () => _getJson('assets/generated10.json')
                      .then((value) => _fetchUsers(value)),
                ),
                RaisedButton(
                  child: Text('Load 100'),
                  onPressed: () => _getJson('assets/generated100.json')
                      .then((value) => _fetchUsers(value)),
                ),
                RaisedButton(
                  child: Text('Load 1000'),
                  onPressed: () => _getJson('assets/generated1000.json')
                      .then((value) => _fetchUsers(value)),
                ),
                RaisedButton(
                  child: Text('Load 10000'),
                  onPressed: () => _getJson('assets/generated10000.json')
                      .then((value) => _fetchUsers(value)),
                )
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _users.length,
                itemBuilder: (context, index) {
                  var user = _users[index];
                  return ListTile(
                    leading: Text('$index'),
                    title: Text('${user.name} '),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<String> _getJson(String path) async {
    return await DefaultAssetBundle.of(context).loadString(path);
  }

  _fetchUsers(String value) {
    widget.fetchUsers
        ?.call(_parseUsers, value)
        ?.then((value) => setUsers(value));
  }

  List<User> _parseUsers(String jsonStr) {
    final parsed = json.decode(jsonStr).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  setUsers(List<User> value) {
    setState(() {
      _users.clear();
      _users.addAll(value);
    });
  }
}
