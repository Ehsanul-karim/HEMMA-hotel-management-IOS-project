
import Foundation

struct Elements: Codable {

  var _typename : String?  = nil
  var header    : Header?  = Header()
  var items     : [Items]? = []

  enum CodingKeys: String, CodingKey {

    case _typename = "__typename"
    case header    = "header"
    case items     = "items"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    _typename = try values.decodeIfPresent(String.self  , forKey: ._typename )
    header    = try values.decodeIfPresent(Header.self  , forKey: .header    )
    items     = try values.decodeIfPresent([Items].self , forKey: .items     )
 
  }

  init() {

  }

}