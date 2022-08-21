import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:file_open_handler/file_open_handler_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  MethodChannelFileOpenHandler platform = MethodChannelFileOpenHandler();
  const MethodChannel channel = MethodChannel('file_open_handler');


  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('openedWithFile', () async {
    expect(await platform.openedWithFile(), '42');
  });
}
