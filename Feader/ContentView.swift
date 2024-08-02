import SwiftUI

struct ContentView: View {
  var body: some View {
//    VStack {
//      Image(systemName: "globe")
//        .imageScale(.large)
//        .foregroundStyle(.tint)
//      Text("Hello, world!")
//    }
//    .padding()
    TabView {
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

#Preview {
  ContentView()
}
