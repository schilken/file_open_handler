import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:file_open_handler/file_open_handler.dart';
import 'package:file_open_handler/file_open_handler_platform_interface.dart';
import 'package:file_open_handler/file_open_handler_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFileOpenHandlerPlatform 
    with MockPlatformInterfaceMixin
    implements FileOpenHandlerPlatform {

  @override
  Future<String?> openedWithFile() => Future.value('ttt.txt');
  
  @override
  void setOnFileDroppedCallback(StringCallback callback) {
    Future.delayed(Duration.zero, () {
      callback('droppedFile.txt');
    });
  }
}

void main() {
  // this must be the first line in main. Otherwise the test will fail.
  TestWidgetsFlutterBinding.ensureInitialized();
  final FileOpenHandlerPlatform initialPlatform = FileOpenHandlerPlatform.instance;

  group('file_open_handler - ', () {
  test('$MethodChannelFileOpenHandler is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFileOpenHandler>());
  });

  test('openedWithFile', () async {
    FileOpenHandler fileOpenHandlerPlugin = FileOpenHandler();
    MockFileOpenHandlerPlatform fakePlatform = MockFileOpenHandlerPlatform();
    FileOpenHandlerPlatform.instance = fakePlatform;
  
    expect(await fileOpenHandlerPlugin.getOpenedFile(), 'ttt.txt');
  });

  test('setOnFileDroppedCallback', () async {
    FileOpenHandler fileOpenHandlerPlugin = FileOpenHandler();
    MockFileOpenHandlerPlatform fakePlatform = MockFileOpenHandlerPlatform();
    FileOpenHandlerPlatform.instance = fakePlatform;
    final completer = Completer<String>();

    fileOpenHandlerPlugin.setOnFileDroppedCallback((String filepath) {
      completer.complete(filepath);
    });

    final result = await completer.future;
    expect(result, 'droppedFile.txt');
  });

  });
}
