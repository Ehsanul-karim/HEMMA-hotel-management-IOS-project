
import Foundation

struct Editorial: Codable {

  var _typename : String?   = nil
  var title     : String?   = nil
  var content   : [String]? = []

  enum CodingKeys: String, CodingKey {

    case _typename = "__typename"
    case title     = "title"
    case content   = "content"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    _typename = try values.decodeIfPresent(String.self   , forKey: ._typename )
    title     = try values.decodeIfPresent(String.self   , forKey: .title     )
    content   = try values.decodeIfPresent([String].self , forKey: .content   )
 
  }

  init() {

  }

}