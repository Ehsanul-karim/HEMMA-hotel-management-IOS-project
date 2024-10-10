
import Foundation

struct Primary: Codable {

  var _typename          : String? = nil
  var value              : String? = nil
  var accessibilityLabel : String? = nil
  var icon               : String? = nil

  enum CodingKeys: String, CodingKey {

    case _typename          = "__typename"
    case value              = "value"
    case accessibilityLabel = "accessibilityLabel"
    case icon               = "icon"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    _typename          = try values.decodeIfPresent(String.self , forKey: ._typename          )
    value              = try values.decodeIfPresent(String.self , forKey: .value              )
    accessibilityLabel = try values.decodeIfPresent(String.self , forKey: .accessibilityLabel )
    icon               = try values.decodeIfPresent(String.self , forKey: .icon               )
 
  }

  init() {

  }

}