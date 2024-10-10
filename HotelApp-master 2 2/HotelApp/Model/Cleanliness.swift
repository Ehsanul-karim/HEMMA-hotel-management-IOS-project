
import Foundation

struct Cleanliness: Codable {

  var _typename   : String?     = nil
  var sectionName : String?     = nil
  var sections    : [Sections]? = []

  enum CodingKeys: String, CodingKey {

    case _typename   = "__typename"
    case sectionName = "sectionName"
    case sections    = "sections"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    _typename   = try values.decodeIfPresent(String.self     , forKey: ._typename   )
    sectionName = try values.decodeIfPresent(String.self     , forKey: .sectionName )
    sections    = try values.decodeIfPresent([Sections].self , forKey: .sections    )
 
  }

  init() {

  }

}