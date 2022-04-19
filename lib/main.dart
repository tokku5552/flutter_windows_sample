import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_windows_sample/setting_page.dart';
import 'package:flutter_windows_sample/type/data.dart';
import 'package:hive_flutter/hive_flutter.dart';

late Box box;

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(DataAdapter());
  box = await Hive.openBox('settings');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(title: '司会役決定つーる'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _result = "";
  late Data _current;

  void _shuffle() {
    log(_current.title);
    log(_current.list[0]);
    setState(() {
      _result = _current.list[0];
    });
  }

  @override
  Future<void> initState() async {
    _current = await box.get('current');
    super.initState();
  }

  void refresh() async {
    setState(() {
      _current = box.get('current');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _result,
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              'に決定しました！',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
                onPressed: _shuffle,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'shuffle',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const SettingPage();
                  },
                  fullscreenDialog: true));
          refresh();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
