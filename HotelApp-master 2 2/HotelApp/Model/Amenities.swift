
import Foundation

struct Amenities: Codable {

  var _typename                  : String?          = nil
  var topAmenities               : TopAmenities?    = TopAmenities()
  var propertyContentPreferences : String?          = nil
  var amenitiesDialog            : AmenitiesDialog? = AmenitiesDialog()
  var takeover                   : Takeover?        = Takeover()

  enum CodingKeys: String, CodingKey {

    case _typename                  = "__typename"
    case topAmenities               = "topAmenities"
    case propertyContentPreferences = "propertyContentPreferences"
    case amenitiesDialog            = "amenitiesDialog"
    case takeover                   = "takeover"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    _typename                  = try values.decodeIfPresent(String.self          , forKey: ._typename                  )
    topAmenities               = try values.decodeIfPresent(TopAmenities.self    , forKey: .topAmenities               )
    propertyContentPreferences = try values.decodeIfPresent(String.self          , forKey: .propertyContentPreferences )
    amenitiesDialog            = try values.decodeIfPresent(AmenitiesDialog.self , forKey: .amenitiesDialog            )
    takeover                   = try values.decodeIfPresent(Takeover.self        , forKey: .takeover                   )
 
  }

  init() {

  }

}