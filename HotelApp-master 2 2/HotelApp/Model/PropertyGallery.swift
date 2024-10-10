
import Foundation

struct PropertyGallery: Codable {

  var _typename              : String?                 = nil
  var imagesGrouped          : String?                 = nil
  var images                 : [Images]?               = []
  var accessibilityLabel     : String?                 = nil
  var thumbnailGalleryDialog : ThumbnailGalleryDialog? = ThumbnailGalleryDialog()
  var mediaGalleryDialog     : MediaGalleryDialog?     = MediaGalleryDialog()

  enum CodingKeys: String, CodingKey {

    case _typename              = "__typename"
    case imagesGrouped          = "imagesGrouped"
    case images                 = "images"
    case accessibilityLabel     = "accessibilityLabel"
    case thumbnailGalleryDialog = "thumbnailGalleryDialog"
    case mediaGalleryDialog     = "mediaGalleryDialog"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    _typename              = try values.decodeIfPresent(String.self                 , forKey: ._typename              )
    imagesGrouped          = try values.decodeIfPresent(String.self                 , forKey: .imagesGrouped          )
    images                 = try values.decodeIfPresent([Images].self               , forKey: .images                 )
    accessibilityLabel     = try values.decodeIfPresent(String.self                 , forKey: .accessibilityLabel     )
    thumbnailGalleryDialog = try values.decodeIfPresent(ThumbnailGalleryDialog.self , forKey: .thumbnailGalleryDialog )
    mediaGalleryDialog     = try values.decodeIfPresent(MediaGalleryDialog.self     , forKey: .mediaGalleryDialog     )
 
  }

  init() {

  }

}