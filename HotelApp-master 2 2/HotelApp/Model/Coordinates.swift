
import Foundation

struct Coordinates: Codable {

  var _typename : String? = nil
  var latitude  : Double? = nil
  var longitude : Double? = nil

  enum CodingKeys: String, CodingKey {

    case _typename = "__typename"
    case latitude  = "latitude"
    case longitude = "longitude"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    _typename = try values.decodeIfPresent(String.self , forKey: ._typename )
    latitude  = try values.decodeIfPresent(Double.self , forKey: .latitude  )
    longitude = try values.decodeIfPresent(Double.self , forKey: .longitude )
 
  }

  init() {

  }

}