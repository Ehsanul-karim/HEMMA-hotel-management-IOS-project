
import Foundation

struct Property: Codable {

  var _typename : String?  = nil
  var header    : Header?  = Header()
  var icon      : Icon?    = Icon()
  var jumpLink  : String?  = nil
  var items     : [Items]? = []

  enum CodingKeys: String, CodingKey {

    case _typename = "__typename"
    case header    = "header"
    case icon      = "icon"
    case jumpLink  = "jumpLink"
    case items     = "items"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    _typename = try values.decodeIfPresent(String.self  , forKey: ._typename )
    header    = try values.decodeIfPresent(Header.self  , forKey: .header    )
    icon      = try values.decodeIfPresent(Icon.self    , forKey: .icon      )
    jumpLink  = try values.decodeIfPresent(String.self  , forKey: .jumpLink  )
    items     = try values.decodeIfPresent([Items].self , forKey: .items     )
 
  }

  init() {

  }

}