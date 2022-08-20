
import 'file_open_handler_platform_interface.dart';

class FileOpenHandler {
  Future<String?> getOpenedFile() {
    return FileOpenHandlerPlatform.instance.openedWithFile();
  }
}
