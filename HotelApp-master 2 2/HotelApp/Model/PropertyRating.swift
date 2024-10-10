
import Foundation

struct PropertyRating: Codable {

  var _typename     : String? = nil
  var rating        : Int?    = nil
  var accessibility : String? = nil
  var icon          : Icon?   = Icon()

  enum CodingKeys: String, CodingKey {

    case _typename     = "__typename"
    case rating        = "rating"
    case accessibility = "accessibility"
    case icon          = "icon"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    _typename     = try values.decodeIfPresent(String.self , forKey: ._typename     )
    rating        = try values.decodeIfPresent(Int.self    , forKey: .rating        )
    accessibility = try values.decodeIfPresent(String.self , forKey: .accessibility )
    icon          = try values.decodeIfPresent(Icon.self   , forKey: .icon          )
 
  }

  init() {

  }

}