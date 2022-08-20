import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'file_open_handler_platform_interface.dart';

/// An implementation of [FileOpenHandlerPlatform] that uses method channels.
class MethodChannelFileOpenHandler extends FileOpenHandlerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('file_open_handler');

  @override
  Future<String?> openedWithFile() async {
    final version = await methodChannel.invokeMethod<String>('openedWithFile');
    return version;
  }
}
