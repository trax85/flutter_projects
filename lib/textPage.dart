import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class textPage extends StatefulWidget {
  final String _str;
  const textPage(this._str);

  @override
  _textPageState createState() => _textPageState();
}

class _textPageState extends State<textPage> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<String?> openDialouge() => showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Save File"),
      content: TextField(
        autofocus: true,
        decoration: const InputDecoration(hintText: 'Enter file name'),
        controller: _controller,
      ),
      actions: [
        TextButton(
            onPressed: submit,
            child: const Text("Save")
        )
      ],
    ),
  );

  void submit(){
    Navigator.of(context).pop(_controller.text);
  }

  Future<String?> getDocumentsPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Documents');
        // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
        // ignore: avoid_slow_async_io
        if (!await directory.exists()) directory = await getExternalStorageDirectory();
      }
    } catch (err, stack) {
      print("Cannot get document folder path");
    }
    return directory?.path;
  }

  _write(String text) async {
    String? dirPath = await getDocumentsPath();
    final String file = "${dirPath!}/$text";
    try {

      await File(file).writeAsString(widget._str);
    }catch(e) {
      print('exception' + e.toString());
    }
    print(text);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Saved File to Documents"),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Save to file"),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 50,),
            SizedBox(height: 200, width: 300, child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(widget._str),
                ),
              ),
            ),
            const SizedBox(height: 50,),
            ElevatedButton(
                onPressed: () async {
                  String? str = await openDialouge();
                  str ??= "temp.txt";
                  _write(str);
                },
                child: const Text("Save file name")
            )
          ]
        ),
      ),
    );
  }
}