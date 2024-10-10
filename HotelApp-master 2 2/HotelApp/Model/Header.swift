
import Foundation

struct Header: Codable {

  var _typename   : String? = nil
  var text        : String? = nil
  var subText     : String? = nil
  var icon        : Icon?   = Icon()
  var headerImage : String? = nil

  enum CodingKeys: String, CodingKey {

    case _typename   = "__typename"
    case text        = "text"
    case subText     = "subText"
    case icon        = "icon"
    case headerImage = "headerImage"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    _typename   = try values.decodeIfPresent(String.self , forKey: ._typename   )
    text        = try values.decodeIfPresent(String.self , forKey: .text        )
    subText     = try values.decodeIfPresent(String.self , forKey: .subText     )
    icon        = try values.decodeIfPresent(Icon.self   , forKey: .icon        )
    headerImage = try values.decodeIfPresent(String.self , forKey: .headerImage )
 
  }

  init() {

  }

}