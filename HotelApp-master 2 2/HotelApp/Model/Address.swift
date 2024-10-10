
import Foundation

struct Address: Codable {

  var _typename         : String? = nil
  var addressLine       : String? = nil
  var city              : String? = nil
  var province          : String? = nil
  var countryCode       : String? = nil
  var firstAddressLine  : String? = nil
  var secondAddressLine : String? = nil

  enum CodingKeys: String, CodingKey {

    case _typename         = "__typename"
    case addressLine       = "addressLine"
    case city              = "city"
    case province          = "province"
    case countryCode       = "countryCode"
    case firstAddressLine  = "firstAddressLine"
    case secondAddressLine = "secondAddressLine"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    _typename         = try values.decodeIfPresent(String.self , forKey: ._typename         )
    addressLine       = try values.decodeIfPresent(String.self , forKey: .addressLine       )
    city              = try values.decodeIfPresent(String.self , forKey: .city              )
    province          = try values.decodeIfPresent(String.self , forKey: .province          )
    countryCode       = try values.decodeIfPresent(String.self , forKey: .countryCode       )
    firstAddressLine  = try values.decodeIfPresent(String.self , forKey: .firstAddressLine  )
    secondAddressLine = try values.decodeIfPresent(String.self , forKey: .secondAddressLine )
 
  }

  init() {

  }

}