
import Foundation

struct Images: Codable {

  var _typename         : String? = nil
  var accessibilityText : String? = nil
  var actionLabel       : String? = nil
  var imageId           : String? = nil
  var image             : Image?  = Image()

  enum CodingKeys: String, CodingKey {

    case _typename         = "__typename"
    case accessibilityText = "accessibilityText"
    case actionLabel       = "actionLabel"
    case imageId           = "imageId"
    case image             = "image"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    _typename         = try values.decodeIfPresent(String.self , forKey: ._typename         )
    accessibilityText = try values.decodeIfPresent(String.self , forKey: .accessibilityText )
    actionLabel       = try values.decodeIfPresent(String.self , forKey: .actionLabel       )
    imageId           = try values.decodeIfPresent(String.self , forKey: .imageId           )
    image             = try values.decodeIfPresent(Image.self  , forKey: .image             )
 
  }

  init() {

  }

}