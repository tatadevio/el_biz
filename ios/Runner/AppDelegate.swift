import Flutter
import UIKit
import Firebase
import FirebaseMessaging
import UserNotifications

@main
@objc class AppDelegate: FlutterAppDelegate {
    
    private let excelChannel = "excel_downloader"
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        GeneratedPluginRegistrant.register(with: self)

        // Notifications setup
        UNUserNotificationCenter.current().delegate = self
        application.registerForRemoteNotifications()

        if #available(iOS 10.0, *) {
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { _, _ in }
        } else {
            let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()

        // ---- ADD METHOD CHANNEL FOR EXCEL DOWNLOAD ----
        let controller = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(
            name: excelChannel,
            binaryMessenger: controller.binaryMessenger
        )

        channel.setMethodCallHandler { [weak self] (call, result) in
            if call.method == "saveExcel" {
                guard let args = call.arguments as? [String: Any],
                      let data = args["bytes"] as? FlutterStandardTypedData,
                      let filename = args["filename"] as? String else {
                    result(FlutterError(code: "INVALID_ARGS", message: "Missing arguments", details: nil))
                    return
                }

                do {
                    let savedPath = try self?.saveExcel(data: data.data, filename: filename)
                    result(savedPath)
                } catch {
                    result(FlutterError(code: "SAVE_FAILED", message: error.localizedDescription, details: nil))
                }
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
        // -------------------------------------------------

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    // Save Excel into iOS Documents/Downloads (visible if UIFileSharingEnabled = YES)
    private func saveExcel(data: Data, filename: String) throws -> String {
        let fm = FileManager.default
        
        let docs = fm.urls(for: .documentDirectory, in: .userDomainMask).first!
        let downloads = docs.appendingPathComponent("Downloads", isDirectory: true)

        // Create folder if not exists
        if !fm.fileExists(atPath: downloads.path) {
            try fm.createDirectory(at: downloads, withIntermediateDirectories: true)
        }

        let fileURL = downloads.appendingPathComponent(filename)
        try data.write(to: fileURL, options: .atomic)

        return fileURL.path  // returned to Flutter
    }
}
