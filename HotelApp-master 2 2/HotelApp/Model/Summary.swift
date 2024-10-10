import Foundation

struct Summary: Codable {

    var _typename                       : String?                          = nil
    var overallScoreWithDescriptionA11y : OverallScoreWithDescriptionA11y? = OverallScoreWithDescriptionA11y()
    var propertyReviewCountDetails      : PropertyReviewCountDetails?      = PropertyReviewCountDetails()
    var highlightMessage                : String?                          = nil
    var seeAllAction                    : SeeAllAction?                    = SeeAllAction()
    var name                            : String?                          = nil
    var tagline                         : String?                          = nil
    var location                         : Location?                          = Location()

    enum CodingKeys: String, CodingKey {

        case _typename                       = "__typename"
        case overallScoreWithDescriptionA11y = "overallScoreWithDescriptionA11y"
        case propertyReviewCountDetails      = "propertyReviewCountDetails"
        case highlightMessage                = "highlightMessage"
        case seeAllAction                    = "seeAllAction"
        case name                            = "name"
        case tagline                         = "tagline"
        case location                         = "location"
        
      
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        _typename                       = try values.decodeIfPresent(String.self                          , forKey: ._typename                       )
        overallScoreWithDescriptionA11y = try values.decodeIfPresent(OverallScoreWithDescriptionA11y.self , forKey: .overallScoreWithDescriptionA11y )
        propertyReviewCountDetails      = try values.decodeIfPresent(PropertyReviewCountDetails.self      , forKey: .propertyReviewCountDetails      )
        highlightMessage                = try values.decodeIfPresent(String.self                          , forKey: .highlightMessage                )
        seeAllAction                    = try values.decodeIfPresent(SeeAllAction.self                    , forKey: .seeAllAction                    )
        name                            = try values.decodeIfPresent(String.self                          , forKey: .name                            )
        tagline                         = try values.decodeIfPresent(String.self                          , forKey: .tagline                         )

        location = try values.decodeIfPresent(Location.self , forKey: .location )

    }

    init() {

    }

}

