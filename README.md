# file_open_handler

Flutter Plugin to handle dropped file on app icon and 'open -a app file'.
## Features

Get the filepath of a file that is given as a parameter to a call like this in the terminal:

```
open -a your-app file-to-open.txt
```

Get the filepath of a file, that is dropped on your app icon in the dock or in the finder.

### Installation

Add this to your package's pubspec.yaml file:

```yaml
dependencies:
  file_open_handler: ^0.0.1
```

Add this to macos/Runner/Info.plist. 
For each file type your app shall be able to open you need a dict.
The example app is prepared to open the extensions txt and md.

```plist
	<key>CFBundleDocumentTypes</key>
	<array>
		<dict>
			<key>CFBundleTypeExtensions</key>
			<array>
				<string>txt</string>
			</array>
			<key>CFBundleTypeName</key>
			<string>Plain Text</string>
			<key>CFBundleTypeRole</key>
			<string>Editor</string>
			<key>LSHandlerRank</key>
			<string>Alternate</string>
			<key>LSItemContentTypes</key>
			<array>
				<string>public.text</string>
				<string>public.plain-text</string>
				<string>public.utf8-plain-text</string>
				<string>public.utf16-external-plain-text</string>
				<string>public.utf16-plain-text</string>
			</array>
		</dict>
		<dict>
			<key>CFBundleTypeExtensions</key>
			<array>
				<string>md</string>
			</array>
			<key>CFBundleTypeName</key>
			<string>Medium Mate</string>
			<key>CFBundleTypeRole</key>
			<string>Viewer</string>
			<key>LSHandlerRank</key>
			<string>Alternate</string>
			<key>LSItemContentTypes</key>
			<array>
				<string>public.text</string>
				<string>public.plain-text</string>
				<string>public.utf8-plain-text</string>
				<string>public.utf16-external-plain-text</string>
				<string>public.utf16-plain-text</string>
			</array>
		</dict>		
	</array>	
```

Add the application:openFile method to macos/Runner/AppDelegate.swift

```swift
import Cocoa
import FlutterMacOS
import file_open_handler

@NSApplicationMain
class AppDelegate: FlutterAppDelegate {
  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }

       override func application(_ sender: NSApplication, openFile filename: String) -> Bool {
         FileOpenHandlerPlugin.instance.handleFileOpen(pathname: filename);
         // Return true if your app opened the file successfully, false otherwise
         return true
     }

}

Get the filepath the Flutter app was opened with like this:

```dart
import 'package:protocol_handler/file_open_handler.dart';

    try {
      openedFile = await _fileOpenHandlerPlugin.getOpenedFile();
    } on PlatformException {
      openedFile = 'Failed to get opened file.';
    }
```

If you want a callback when a file is dropped onto the app icon use this code snippet:

```dart
    _fileOpenHandlerPlugin.setOnFileDroppedCallback((String? filepath) {
      setState(() {
        _droppedFile = filepath ?? 'Unknown';
      });
    });

```
See example for a minimal macOS app using this plugin.


## Unit Tests

✓ file_open_handler_method_channel -  openedWithFile
✓ file_open_handler -  MethodChannelFileOpenHandler is the default instance
✓ file_open_handler -  openedWithFile
✓ file_open_handler -  setOnFileDroppedCallback

The implementation is inspired by the protocol_handler plugin by leanflutter.org.  


