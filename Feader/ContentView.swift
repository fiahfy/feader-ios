import SwiftUI

struct ContentView: View {
  var body: some View {
    TabView {
      Group {
        HomeView()
          .tabItem {
            Label("Home", systemImage: "house")
          }

        SettingsView()
          .tabItem {
            Label("Settings", systemImage: "gearshape")
          }
      }
      .toolbarBackground(.visible, for: .tabBar)
    }
  }
}

#Preview {
  ContentView()
}
