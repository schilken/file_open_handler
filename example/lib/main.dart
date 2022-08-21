import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:file_open_handler/file_open_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _openedWithFile;
  String _droppedFile = 'not yet dropped';
  final _fileOpenHandlerPlugin = FileOpenHandler();

  @override
  void initState() {
    super.initState();
    _fileOpenHandlerPlugin.setOnFileDroppedCallback((String? filepath) {
      setState(() {
        _droppedFile = filepath ?? 'Unknown';
      });
    });
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String? openedFile;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      openedFile = await _fileOpenHandlerPlugin.getOpenedFile();
    } on PlatformException {
      openedFile = 'Failed to get opened file.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _openedWithFile = openedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('FileOpenPlugin example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Opened with: $_openedWithFile'),
              Text('Dropped File: $_droppedFile'),
            ],
          ),
        ),
      ),
    );
  }
}
