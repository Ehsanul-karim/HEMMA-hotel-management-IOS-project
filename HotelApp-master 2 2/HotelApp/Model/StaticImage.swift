
import Foundation

struct StaticImage: Codable {

  var _typename   : String? = nil
  var description : String? = nil
  var url         : String? = nil
  var aspectRatio : String? = nil

  enum CodingKeys: String, CodingKey {

    case _typename   = "__typename"
    case description = "description"
    case url         = "url"
    case aspectRatio = "aspectRatio"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    _typename   = try values.decodeIfPresent(String.self , forKey: ._typename   )
    description = try values.decodeIfPresent(String.self , forKey: .description )
    url         = try values.decodeIfPresent(String.self , forKey: .url         )
    aspectRatio = try values.decodeIfPresent(String.self , forKey: .aspectRatio )
 
  }

  init() {

  }

}