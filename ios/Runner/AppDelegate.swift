import Flutter
import UIKit
import Firebase
import FirebaseMessaging
import UserNotifications

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // FirebaseApp.configure()
    // Messaging.messaging().delegate = self
    GeneratedPluginRegistrant.register(with: self)
        UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
        application.registerForRemoteNotifications()

    if #available(iOS 10.0, *) {
        // For iOS 10 display notification (sent via APNS)
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
    } else {
        let settings: UIUserNotificationSettings =
        UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
        application.registerUserNotificationSettings(settings)
    }
    application.registerForRemoteNotifications()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  
  // {
  //   // GeneratedPluginRegistrant.register(with: self)
  //    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
  //   GeneratedPluginRegistrant.register(with: registry)
  // }
  //   return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  // }
}
