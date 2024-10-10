
import Foundation

struct Items: Codable {

  var _typename : String?     = nil
  var contents  : [Contents]? = []

  enum CodingKeys: String, CodingKey {

    case _typename = "__typename"
    case contents  = "contents"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    _typename = try values.decodeIfPresent(String.self     , forKey: ._typename )
    contents  = try values.decodeIfPresent([Contents].self , forKey: .contents  )
 
  }

  init() {

  }

}