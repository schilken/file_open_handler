import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'file_open_handler_method_channel.dart';

abstract class FileOpenHandlerPlatform extends PlatformInterface {
  /// Constructs a FileOpenHandlerPlatform.
  FileOpenHandlerPlatform() : super(token: _token);

  static final Object _token = Object();

  static FileOpenHandlerPlatform _instance = MethodChannelFileOpenHandler();

  /// The default instance of [FileOpenHandlerPlatform] to use.
  ///
  /// Defaults to [MethodChannelFileOpenHandler].
  static FileOpenHandlerPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FileOpenHandlerPlatform] when
  /// they register themselves.
  static set instance(FileOpenHandlerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> openedWithFile() {
    throw UnimplementedError('openedWithFile() has not been implemented.');
  }
}
