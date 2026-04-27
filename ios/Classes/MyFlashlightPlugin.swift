import Flutter
import UIKit

public class MyFlashlightPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "my_flashlight_plugin", binaryMessenger: registrar.messenger())
    let instance = MyFlashlightPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "isSupported":
      result(false)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
