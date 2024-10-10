
import Foundation

struct MultiCityRegion: Codable {

  var _typename : String? = nil
  var id        : String? = nil

  enum CodingKeys: String, CodingKey {

    case _typename = "__typename"
    case id        = "id"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    _typename = try values.decodeIfPresent(String.self , forKey: ._typename )
    id        = try values.decodeIfPresent(String.self , forKey: .id        )
 
  }

  init() {

  }

}