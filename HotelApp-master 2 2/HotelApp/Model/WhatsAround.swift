
import Foundation

struct WhatsAround: Codable {

  var _typename : String?    = nil
  var editorial : Editorial? = Editorial()

  enum CodingKeys: String, CodingKey {

    case _typename = "__typename"
    case editorial = "editorial"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    _typename = try values.decodeIfPresent(String.self    , forKey: ._typename )
    editorial = try values.decodeIfPresent(Editorial.self , forKey: .editorial )
 
  }

  init() {

  }

}