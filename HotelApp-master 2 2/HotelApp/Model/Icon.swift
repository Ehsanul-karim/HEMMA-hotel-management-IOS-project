
import Foundation

struct Icon: Codable {

  var _typename   : String? = nil
  var id          : String? = nil
  var description : String? = nil
  var size        : String? = nil
  var token       : String? = nil
  var theme       : String? = nil

  enum CodingKeys: String, CodingKey {

    case _typename   = "__typename"
    case id          = "id"
    case description = "description"
    case size        = "size"
    case token       = "token"
    case theme       = "theme"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    _typename   = try values.decodeIfPresent(String.self , forKey: ._typename   )
    id          = try values.decodeIfPresent(String.self , forKey: .id          )
    description = try values.decodeIfPresent(String.self , forKey: .description )
    size        = try values.decodeIfPresent(String.self , forKey: .size        )
    token       = try values.decodeIfPresent(String.self , forKey: .token       )
    theme       = try values.decodeIfPresent(String.self , forKey: .theme       )
 
  }

  init() {

  }

}