
import Foundation

struct ReviewInfo: Codable {

  var _typename : String?  = nil
  var summary   : Summary? = Summary()

  enum CodingKeys: String, CodingKey {

    case _typename = "__typename"
    case summary   = "summary"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    _typename = try values.decodeIfPresent(String.self  , forKey: ._typename )
    summary   = try values.decodeIfPresent(Summary.self , forKey: .summary   )
 
  }

  init() {

  }

}