
import Foundation

struct OverallScoreWithDescriptionA11y: Codable {

  var _typename : String? = nil
  var value     : String? = nil

  enum CodingKeys: String, CodingKey {

    case _typename = "__typename"
    case value     = "value"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    _typename = try values.decodeIfPresent(String.self , forKey: ._typename )
    value     = try values.decodeIfPresent(String.self , forKey: .value     )
 
  }

  init() {

  }

}