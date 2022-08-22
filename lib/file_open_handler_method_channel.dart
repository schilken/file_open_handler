import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'file_open_handler_platform_interface.dart';

/// An implementation of [FileOpenHandlerPlatform] that uses method channels.
class MethodChannelFileOpenHandler extends FileOpenHandlerPlatform {
  MethodChannelFileOpenHandler() {
    methodChannel.setMethodCallHandler(_methodCallHandler);
  }

  Future<void> _methodCallHandler(MethodCall call) async {
    if (call.method == 'onFileDropped') {
      _onFileDroppedCallback?.call(call.arguments['filepath']);
    } else {
      throw UnimplementedError();
    }
  }

  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('file_open_handler');
  StringCallback? _onFileDroppedCallback;

  @override
  Future<String?> openedWithFile() async {
    final version = await methodChannel.invokeMethod<String>('openedWithFile');
    return version;
  }

  @override
  void setOnFileDroppedCallback(StringCallback callback) {
    _onFileDroppedCallback = callback;
  }
}
