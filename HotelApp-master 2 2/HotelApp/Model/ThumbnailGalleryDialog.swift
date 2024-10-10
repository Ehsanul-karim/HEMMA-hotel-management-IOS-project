
import Foundation

struct ThumbnailGalleryDialog: Codable {

  var _typename : String?  = nil
  var trigger   : Trigger? = Trigger()
  var toolbar   : Toolbar? = Toolbar()

  enum CodingKeys: String, CodingKey {

    case _typename = "__typename"
    case trigger   = "trigger"
    case toolbar   = "toolbar"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    _typename = try values.decodeIfPresent(String.self  , forKey: ._typename )
    trigger   = try values.decodeIfPresent(Trigger.self , forKey: .trigger   )
    toolbar   = try values.decodeIfPresent(Toolbar.self , forKey: .toolbar   )
 
  }

  init() {

  }

}