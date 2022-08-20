import Cocoa
import FlutterMacOS

public class FileOpenHandlerPlugin: NSObject, FlutterPlugin {
  private static var _instance: FileOpenHandlerPlugin?
  private var _initialFilepath: String?

      public static var instance: FileOpenHandlerPlugin {
      get {
        return _instance!
      }
    }


  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "file_open_handler", binaryMessenger: registrar.messenger)
    let instance = FileOpenHandlerPlugin()
        _instance = instance
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "openedWithFile":
      result(_initialFilepath ?? "no file")
    default:
      result(FlutterMethodNotImplemented)
    }
  }

      @objc
    public func handleFileOpen(pathname: String) {
//        print("openning file \(pathname)")
        // let args: NSDictionary = [
        //     "filepath": pathname,
        // ]
        _initialFilepath = pathname
//        channel.invokeMethod("onFileOpen", arguments: args, result: nil)
    }
}
