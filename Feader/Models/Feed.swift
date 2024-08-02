import Foundation

struct Feed: Codable {
  let entries: [Entry]

  private enum CodingKeys: String, CodingKey {
    case entries = "entry"
  }
}
