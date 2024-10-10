
import Foundation

struct Contents: Codable {

  var _typename : String?  = nil
  var primary   : Primary? = Primary()
  var secondary : String?  = nil

  enum CodingKeys: String, CodingKey {

    case _typename = "__typename"
    case primary   = "primary"
    case secondary = "secondary"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    _typename = try values.decodeIfPresent(String.self  , forKey: ._typename )
    primary   = try values.decodeIfPresent(Primary.self , forKey: .primary   )
    secondary = try values.decodeIfPresent(String.self  , forKey: .secondary )
 
  }

  init() {

  }

}