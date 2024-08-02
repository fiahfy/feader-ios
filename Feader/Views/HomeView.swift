import SwiftUI

struct HomeView: View {
  @ObservedObject
  private var viewModel = HomeViewModel()

  var body: some View {
    NavigationView {
      List(viewModel.entries, id: \.id) { entry in
        Text(entry.title)
          .font(.body)
          .foregroundColor(.primary)
      }
      .refreshable {
        await viewModel.load()
      }
      .task {
        await viewModel.load()
      }
      .navigationTitle("Feeds")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

#Preview {
  HomeView()
}
