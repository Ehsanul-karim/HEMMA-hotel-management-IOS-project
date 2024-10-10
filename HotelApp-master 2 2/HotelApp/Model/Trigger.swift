
import Foundation

struct Trigger: Codable {

  var _typename           : String?              = nil
  var clientSideAnalytics : ClientSideAnalytics? = ClientSideAnalytics()

  enum CodingKeys: String, CodingKey {

    case _typename           = "__typename"
    case clientSideAnalytics = "clientSideAnalytics"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    _typename           = try values.decodeIfPresent(String.self              , forKey: ._typename           )
    clientSideAnalytics = try values.decodeIfPresent(ClientSideAnalytics.self , forKey: .clientSideAnalytics )
 
  }

  init() {

  }

}