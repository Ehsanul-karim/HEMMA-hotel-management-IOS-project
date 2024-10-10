
import Foundation

struct HotelDetails: Codable {

  var _typename                    : String?                       = nil
  var summary                      : Summary?                      = Summary()
  var propertyGallery              : PropertyGallery?              = PropertyGallery()
  var reviewInfo                   : ReviewInfo?                   = ReviewInfo()
  var propertyContentSectionGroups : PropertyContentSectionGroups? = PropertyContentSectionGroups()

  enum CodingKeys: String, CodingKey {

    case _typename                    = "__typename"
    case summary                      = "summary"
    case propertyGallery              = "propertyGallery"
    case reviewInfo                   = "reviewInfo"
    case propertyContentSectionGroups = "propertyContentSectionGroups"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    _typename                    = try values.decodeIfPresent(String.self                       , forKey: ._typename                    )
    summary                      = try values.decodeIfPresent(Summary.self                      , forKey: .summary                      )
    propertyGallery              = try values.decodeIfPresent(PropertyGallery.self              , forKey: .propertyGallery              )
    reviewInfo                   = try values.decodeIfPresent(ReviewInfo.self                   , forKey: .reviewInfo                   )
    propertyContentSectionGroups = try values.decodeIfPresent(PropertyContentSectionGroups.self , forKey: .propertyContentSectionGroups )
 
  }

  init() {

  }

}