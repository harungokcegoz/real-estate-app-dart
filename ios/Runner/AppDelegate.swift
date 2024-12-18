import Flutter
import UIKit
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller = window?.rootViewController as! FlutterViewController
    let googleMapsChannel = FlutterMethodChannel(
      name: "com.realestate.app/config",
      binaryMessenger: controller.binaryMessenger)
    
    googleMapsChannel.setMethodCallHandler { [weak self] (call, result) in
      if call.method == "getGoogleMapsApiKey" {
        // Replace this with your actual API key
        result("AIzaSyDeqHzkvAkI-tYpkz3-j86fpHGC67RY1L0")
      } else {
        result(FlutterMethodNotImplemented)
      }
    }
    
    GMSServices.provideAPIKey("AIzaSyDeqHzkvAkI-tYpkz3-j86fpHGC67RY1L0")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
