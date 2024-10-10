
import Foundation

struct Takeover: Codable {

  var _typename       : String?      = nil
  var amenityClosures : String?      = nil
  var highlight       : [Highlight]? = []
  var property        : [Property]?  = []

  enum CodingKeys: String, CodingKey {

    case _typename       = "__typename"
    case amenityClosures = "amenityClosures"
    case highlight       = "highlight"
    case property        = "property"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    _typename       = try values.decodeIfPresent(String.self      , forKey: ._typename       )
    amenityClosures = try values.decodeIfPresent(String.self      , forKey: .amenityClosures )
    highlight       = try values.decodeIfPresent([Highlight].self , forKey: .highlight       )
    property        = try values.decodeIfPresent([Property].self  , forKey: .property        )
 
  }

  init() {

  }

}