
import Foundation

struct ClientSideAnalytics: Codable {

  var _typename  : String? = nil
  var linkName   : String? = nil
  var referrerId : String? = nil

  enum CodingKeys: String, CodingKey {

    case _typename  = "__typename"
    case linkName   = "linkName"
    case referrerId = "referrerId"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    _typename  = try values.decodeIfPresent(String.self , forKey: ._typename  )
    linkName   = try values.decodeIfPresent(String.self , forKey: .linkName   )
    referrerId = try values.decodeIfPresent(String.self , forKey: .referrerId )
 
  }

  init() {

  }

}