import SwiftUI

@MainActor
class HomeViewModel: ObservableObject {
  @Published
  var entries = [Entry]()

  func load() async {
    do {
      let url = URL(string: "https://fiahfy.blogspot.com/feeds/posts/summary?alt=json")!
      let (data, _) = try await URLSession.shared.data(from: url)
      let summary = try? JSONDecoder().decode(Summary.self, from: data)
      guard let summary = summary else {
        return
      }
      entries = summary.feed.entries
    } catch {
      // TODO: handle error
      return
    }
  }
}