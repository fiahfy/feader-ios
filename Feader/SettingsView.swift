import SwiftUI

struct SettingsView: View {
  private var appVersion: String {
    Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
  }

  private var buildVersion: String {
    Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "Unknown"
  }

  var body: some View {
    NavigationView {
      Form {
        Section {
          HStack {
            Text("Version")
              .font(.body)
              .foregroundColor(.primary)

            Spacer()

            Text("\(appVersion) (\(buildVersion))")
              .font(.body)
              .foregroundColor(.secondary)
          }
        }
      }
      .navigationTitle("Settings")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

#Preview {
  SettingsView()
}
