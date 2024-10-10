
import Foundation

struct Location: Codable {

  var _typename       : String?          = nil
  var address         : Address?         = Address()
  var coordinates     : Coordinates?     = Coordinates()
  var multiCityRegion : MultiCityRegion? = MultiCityRegion()
  var whatsAround     : WhatsAround?     = WhatsAround()
  var mapDialog       : MapDialog?       = MapDialog()
  var staticImage     : StaticImage?     = StaticImage()

  enum CodingKeys: String, CodingKey {

    case _typename       = "__typename"
    case address         = "address"
    case coordinates     = "coordinates"
    case multiCityRegion = "multiCityRegion"
    case whatsAround     = "whatsAround"
    case mapDialog       = "mapDialog"
    case staticImage     = "staticImage"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    _typename       = try values.decodeIfPresent(String.self          , forKey: ._typename       )
    address         = try values.decodeIfPresent(Address.self         , forKey: .address         )
    coordinates     = try values.decodeIfPresent(Coordinates.self     , forKey: .coordinates     )
    multiCityRegion = try values.decodeIfPresent(MultiCityRegion.self , forKey: .multiCityRegion )
    whatsAround     = try values.decodeIfPresent(WhatsAround.self     , forKey: .whatsAround     )
    mapDialog       = try values.decodeIfPresent(MapDialog.self       , forKey: .mapDialog       )
    staticImage     = try values.decodeIfPresent(StaticImage.self     , forKey: .staticImage     )
 
  }

  init() {

  }

}