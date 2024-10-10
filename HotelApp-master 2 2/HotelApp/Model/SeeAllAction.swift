
import Foundation

struct SeeAllAction: Codable {

  var _typename : String?  = nil
  var trigger   : Trigger? = Trigger()

  enum CodingKeys: String, CodingKey {

    case _typename = "__typename"
    case trigger   = "trigger"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    _typename = try values.decodeIfPresent(String.self  , forKey: ._typename )
    trigger   = try values.decodeIfPresent(Trigger.self , forKey: .trigger   )
 
  }

  init() {

  }

}