import SwiftUI

class SettingsViewModel: ObservableObject {
  private var appVersion: String {
    Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
  }

  private var buildVersion: String {
    Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "Unknown"
  }

  var version: String {
    "\(appVersion) (\(buildVersion))"
  }
}
