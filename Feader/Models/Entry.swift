import Foundation

struct Entry: Codable {
  let id: String
  let title: String
  let links: [Link]

  var permalink: String? {
    links.filter { $0.rel == "alternate" }.first?.href
  }

  enum CodingKeys: String, CodingKey {
    case id
    case title
    case links = "link"
  }

  enum IdCodingKeys: String, CodingKey {
    case value = "$t"
  }

  enum TitleCodingKeys: String, CodingKey {
    case value = "$t"
  }

  init(from decoder: Decoder) throws {
    let rootContainer = try decoder.container(keyedBy: CodingKeys.self)
    let idContainer = try rootContainer.nestedContainer(keyedBy: IdCodingKeys.self, forKey: .id)
    let titleContainer = try rootContainer.nestedContainer(keyedBy: TitleCodingKeys.self, forKey: .title)

    self.links = try rootContainer.decode([Link].self, forKey: .links)
    self.id = try idContainer.decode(String.self, forKey: .value)
    self.title = try titleContainer.decode(String.self, forKey: .value)
  }

  func encode(to encoder: Encoder) throws {
    var rootContainer = encoder.container(keyedBy: CodingKeys.self)
    var idContainer = rootContainer.nestedContainer(keyedBy: IdCodingKeys.self, forKey: .id)
    var titleContainer = rootContainer.nestedContainer(keyedBy: TitleCodingKeys.self, forKey: .title)

    try rootContainer.encode(links, forKey: .links)
    try idContainer.encode(id, forKey: .value)
    try titleContainer.encode(title, forKey: .value)
  }
}
