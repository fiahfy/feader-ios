import SwiftUI

struct LoadingViewModifier: ViewModifier {
  var isLoading = false

  func body(content: Content) -> some View {
    content
      .overlay {
        if isLoading {
          ZStack {
            Color.white.opacity(0.01)
            ProgressView().progressViewStyle(.circular)
          }
        }
      }
  }
}

extension View {
  func loading(_ isLoading: Bool) -> some View {
    modifier(LoadingViewModifier(isLoading: isLoading))
  }
}
