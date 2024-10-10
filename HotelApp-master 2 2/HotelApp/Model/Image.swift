
import Foundation

struct Image: Codable {

  var _typename   : String? = nil
  var url         : String? = nil
  var description : String? = nil

  enum CodingKeys: String, CodingKey {

    case _typename   = "__typename"
    case url         = "url"
    case description = "description"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    _typename   = try values.decodeIfPresent(String.self , forKey: ._typename   )
    url         = try values.decodeIfPresent(String.self , forKey: .url         )
    description = try values.decodeIfPresent(String.self , forKey: .description )
 
  }

  init() {

  }

}