import SwiftUI

struct HomeView: View {
  @ObservedObject
  private var viewModel = HomeViewModel()

  @State
  private var isPresented = false
  @State
  private var selectedIndex = 0

  var body: some View {
    NavigationView {
      List(viewModel.entries.indices, id: \.self) { index in
        Button {
          isPresented = true
          selectedIndex = index
        } label: {
          let entry = viewModel.entries[index]
          Text(entry.title)
            .font(.body)
            .foregroundColor(.primary)
        }
      }
      .navigationTitle("Feeds")
      .navigationBarTitleDisplayMode(.inline)
      .task {
        await viewModel.load()
      }
      .refreshable {
        await viewModel.load()
      }
      .sheet(isPresented: $isPresented) {
        if let permalink = viewModel.entries[selectedIndex].permalink {
          NavigationWebView(urlString: permalink, isPresented: $isPresented)
            .presentationDragIndicator(.visible)
        }
      }
      .loading(viewModel.isLoading)
    }
  }
}

#Preview {
  HomeView()
}
