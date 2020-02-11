import AppKit

public indirect enum DimensionType: Codable & Equatable {
  case fitContent
  case fill
  case fixed(CGFloat)

  // MARK: Codable

  public enum CodingKeys: CodingKey {
    case type
    case data
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let type = try container.decode(String.self, forKey: .type)

    switch type {
      case "fitContent":
        self = .fitContent
      case "fill":
        self = .fill
      case "fixed":
        self = .fixed(try container.decode(CGFloat.self, forKey: .data))
      default:
        fatalError("Failed to decode enum due to invalid case type.")
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)

    switch self {
      case .fitContent:
        try container.encode("fitContent", forKey: .type)
      case .fill:
        try container.encode("fill", forKey: .type)
      case .fixed(let value):
        try container.encode("fixed", forKey: .type)
        try container.encode(value, forKey: .data)
    }
  }
}