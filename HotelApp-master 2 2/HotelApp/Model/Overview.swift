
import Foundation

struct Overview: Codable {

  var _typename          : String?         = nil
  var vipMessaging       : String?         = nil
  var inventoryType      : String?         = nil
  var accessibilityLabel : String?         = nil
  var label              : String?         = nil
  var propertyRating     : PropertyRating? = PropertyRating()

  enum CodingKeys: String, CodingKey {

    case _typename          = "__typename"
    case vipMessaging       = "vipMessaging"
    case inventoryType      = "inventoryType"
    case accessibilityLabel = "accessibilityLabel"
    case label              = "label"
    case propertyRating     = "propertyRating"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    _typename          = try values.decodeIfPresent(String.self         , forKey: ._typename          )
    vipMessaging       = try values.decodeIfPresent(String.self         , forKey: .vipMessaging       )
    inventoryType      = try values.decodeIfPresent(String.self         , forKey: .inventoryType      )
    accessibilityLabel = try values.decodeIfPresent(String.self         , forKey: .accessibilityLabel )
    label              = try values.decodeIfPresent(String.self         , forKey: .label              )
    propertyRating     = try values.decodeIfPresent(PropertyRating.self , forKey: .propertyRating     )
 
  }

  init() {

  }

}