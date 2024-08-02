import SwiftUI

struct ContentView: View {
  var body: some View {
    TabView {
      Group {
        HomeView()
          .tabItem {
            Image(systemName: "house")
          }

        SettingsView()
          .tabItem {
            Image(systemName: "gearshape")
          }
      }
    }
  }
}

#Preview {
  ContentView()
}
