import 'package:flutter/material.dart';
import 'package:flutter_windows_sample/main.dart';
import 'package:flutter_windows_sample/type/data.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  String _title = '';
  final TextEditingController _titleController = TextEditingController();
  final List<String> _list = [];
  final List<TextEditingController> _itemControllers = [];

  void addField() {
    setState(() {
      _list.add('');
      _itemControllers.add(TextEditingController());
    });
  }

  Future<void> save() async {
    _title = _titleController.text;
    await box.put(_title, Data(list: _list, title: _title));
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('追加'),
        ),
        body: Column(
          children: [
            TextField(
              controller: _titleController,
            ),
            IconButton(onPressed: addField, icon: const Icon(Icons.add)),
            Flexible(
              child: ListView.builder(
                  itemCount: _list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TextField(
                      controller: _itemControllers[index],
                    );
                  }),
            ),
            ElevatedButton(onPressed: save, child: Text('保存'))
          ],
        ));
  }
}
