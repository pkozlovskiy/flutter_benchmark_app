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
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Benchmark'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            RaisedButton(
              key: ValueKey('refresh'),
              child: Text('Refresh'),
              onPressed: () => _refreshIndicatorKey.currentState.show(),
            ),
            Expanded(
              child: RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: _handleRefresh,
                child: ListView.builder(
                  key: ValueKey('list'),
                  itemCount: _users.length,
                  itemBuilder: (context, index) {
                    var user = _users[index];
                    return ListTile(
                      key: ValueKey('item_$index'),
                      leading: Text('$index'),
                      title: Text('${user.name} '),
                      subtitle: Text('item_$index'),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<Null> _handleRefresh() {
    return _getJson('assets/generated10000.json')
        .then((value) => _fetchUsers(value));
  }

  Future<String> _getJson(String path) async {
    return await DefaultAssetBundle.of(context).loadString(path);
  }

  _fetchUsers(String value) {
    widget.fetchUsers
        ?.call(_parseUsers, value)
        ?.then((value) => setUsers(value));
  }

  setUsers(List<User> value) {
    setState(() {
      _users.clear();
      _users.addAll(value);
    });
  }
}

List<User> _parseUsers(String jsonStr) {
  final parsed = json.decode(jsonStr).cast<Map<String, dynamic>>();
  return parsed.map<User>((json) => User.fromJson(json)).toList();
}
