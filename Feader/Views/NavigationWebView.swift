import Combine
import SwiftUI
import WebKit

struct NavigationWebView: View {
  var urlString: String

  @Binding
  var isPresented: Bool

  @State
  private var title = ""
  @State
  private var isLoading = false

  var body: some View {
    NavigationView {
      WebView(urlString: urlString, title: $title, isLoading: $isLoading)
        .navigationBarTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
          Button(action: {
            isPresented = false
          }, label: {
            Image(systemName: "xmark")
          })
        }
        .loading(isLoading)
    }
  }
}

struct WebView: UIViewRepresentable {
  var urlString: String

  @Binding
  var title: String
  @Binding
  var isLoading: Bool

  class Cordinator: NSObject, WKNavigationDelegate {
    var webView: WebView

    init(_ webView: WebView) {
      self.webView = webView
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
      self.webView.title = webView.title ?? ""
    }
  }

  func makeCoordinator() -> Cordinator {
    Cordinator(self)
  }

  func makeUIView(context: Context) -> WKWebView {
    let webView = WKWebView()
    webView.navigationDelegate = context.coordinator
    return webView
  }

  func updateUIView(_ uiView: WKWebView, context: Context) {
    guard let url = URL(string: urlString) else {
      return
    }

    uiView.load(URLRequest(url: url))
  }
}

#Preview {
  NavigationWebView(urlString: "https://www.google.com", isPresented: .constant(true))
}
