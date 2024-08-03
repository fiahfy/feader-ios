import SwiftUI

struct SettingsView: View {
  @StateObject
  private var viewModel = SettingsViewModel()

  var body: some View {
    NavigationView {
      Form {
        Section {
          HStack {
            Text("Version")
              .font(.body)
              .foregroundColor(.primary)

            Spacer()

            Text(viewModel.version)
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
