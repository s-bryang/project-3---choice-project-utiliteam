import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    //Adding API Key
    GMSServices.provideAPIKey("AIzaSyCAVWZgFxWt3Q9piFwqYNfkesx1fGsYiJI")
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
