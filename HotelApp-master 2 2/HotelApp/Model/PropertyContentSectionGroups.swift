
import Foundation

struct PropertyContentSectionGroups: Codable {

  var _typename   : String?      = nil
  var cleanliness : Cleanliness? = Cleanliness()

  enum CodingKeys: String, CodingKey {

    case _typename   = "__typename"
    case cleanliness = "cleanliness"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    _typename   = try values.decodeIfPresent(String.self      , forKey: ._typename   )
    cleanliness = try values.decodeIfPresent(Cleanliness.self , forKey: .cleanliness )
 
  }

  init() {

  }

}