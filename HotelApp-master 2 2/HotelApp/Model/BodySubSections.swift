
import Foundation

struct BodySubSections: Codable {

  var _typename  : String?     = nil
  var elements   : [Elements]? = []
  var expando    : String?     = nil
  var maxColumns : Int?        = nil

  enum CodingKeys: String, CodingKey {

    case _typename  = "__typename"
    case elements   = "elements"
    case expando    = "expando"
    case maxColumns = "maxColumns"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    _typename  = try values.decodeIfPresent(String.self     , forKey: ._typename  )
    elements   = try values.decodeIfPresent([Elements].self , forKey: .elements   )
    expando    = try values.decodeIfPresent(String.self     , forKey: .expando    )
    maxColumns = try values.decodeIfPresent(Int.self        , forKey: .maxColumns )
 
  }

  init() {

  }

}