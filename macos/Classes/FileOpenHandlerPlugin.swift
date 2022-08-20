import Cocoa
import FlutterMacOS

public class FileOpenHandlerPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "file_open_handler", binaryMessenger: registrar.messenger)
    let instance = FileOpenHandlerPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "openedWithFile":
      result("ttt.md")
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
