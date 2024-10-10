
import Foundation

struct PropertyReviewCountDetails: Codable {

  var _typename        : String? = nil
  var shortDescription : String? = nil

  enum CodingKeys: String, CodingKey {

    case _typename        = "__typename"
    case shortDescription = "shortDescription"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    _typename        = try values.decodeIfPresent(String.self , forKey: ._typename        )
    shortDescription = try values.decodeIfPresent(String.self , forKey: .shortDescription )
 
  }

  init() {

  }

}