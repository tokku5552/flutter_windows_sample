import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_windows_sample/add_page.dart';
import 'package:flutter_windows_sample/main.dart';
import 'package:flutter_windows_sample/type/data.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late List<dynamic> list;

  @override
  void initState() {
    list = box.values.toList();
    log('list length :${list.length}');
    super.initState();
  }

  void refresh() {
    setState(() {
      list = box.values.toList();
    });
  }

  Future<void> setCurrent(Data data) async {
    final currentData = await box.get(data.title);
    await box.put('current', currentData);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
      ),
      body: list.isNotEmpty
          ? ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  child: _ListItem(list[index]),
                  onTap: () => setCurrent(list[index]),
                );
              })
          : const Center(
              child: Text('Nothing data'),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) {
                  return const AddPage();
                },
                fullscreenDialog: true),
          );
          refresh();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  const _ListItem(this._data);
  final Data _data;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_data.title),
    );
  }
}
