
import Foundation

struct StarRatingIcon: Codable {

  var _typename : String? = nil
  var token     : String? = nil

  enum CodingKeys: String, CodingKey {

    case _typename = "__typename"
    case token     = "token"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    _typename = try values.decodeIfPresent(String.self , forKey: ._typename )
    token     = try values.decodeIfPresent(String.self , forKey: .token     )
 
  }

  init() {

  }

}