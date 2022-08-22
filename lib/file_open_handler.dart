import 'file_open_handler_platform_interface.dart';

class FileOpenHandler {
  /// Returns the filepath of the file that the app was opened with.
  /// f.e. in the terminal: open -a app file.txt
  Future<String?> getOpenedFile() {
    return FileOpenHandlerPlatform.instance.openedWithFile();
  }

  /// Sets the callback that is called when a file is dropped on the app icon.
  setOnFileDroppedCallback(StringCallback callback) {
    FileOpenHandlerPlatform.instance.setOnFileDroppedCallback(callback);
  }
}
