
import Foundation

struct Sections: Codable {

  var _typename       : String?            = nil
  var sectionName     : String?            = nil
  var header          : Header?            = Header()
  var bodySubSections : [BodySubSections]? = []
  var action          : String?            = nil

  enum CodingKeys: String, CodingKey {

    case _typename       = "__typename"
    case sectionName     = "sectionName"
    case header          = "header"
    case bodySubSections = "bodySubSections"
    case action          = "action"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    _typename       = try values.decodeIfPresent(String.self            , forKey: ._typename       )
    sectionName     = try values.decodeIfPresent(String.self            , forKey: .sectionName     )
    header          = try values.decodeIfPresent(Header.self            , forKey: .header          )
    bodySubSections = try values.decodeIfPresent([BodySubSections].self , forKey: .bodySubSections )
    action          = try values.decodeIfPresent(String.self            , forKey: .action          )
 
  }

  init() {

  }

}