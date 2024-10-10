
import Foundation

struct Toolbar: Codable {

  var _typename           : String? = nil
  var title               : String? = nil
  var icon                : Icon?   = Icon()
  var clientSideAnalytics : String? = nil

  enum CodingKeys: String, CodingKey {

    case _typename           = "__typename"
    case title               = "title"
    case icon                = "icon"
    case clientSideAnalytics = "clientSideAnalytics"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    _typename           = try values.decodeIfPresent(String.self , forKey: ._typename           )
    title               = try values.decodeIfPresent(String.self , forKey: .title               )
    icon                = try values.decodeIfPresent(Icon.self   , forKey: .icon                )
    clientSideAnalytics = try values.decodeIfPresent(String.self , forKey: .clientSideAnalytics )
 
  }

  init() {

  }

}