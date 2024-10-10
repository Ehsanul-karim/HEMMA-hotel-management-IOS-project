//
//  BookingList.swift
//  HotelApp
//
//  Created by Biduit on 26/11/23.
//  Copyright © 2023 MACBOOK PRO RETINA. All rights reserved.
//

import UIKit

class Hotel: NSObject {
    
    var hotelName: String?
    var hotelStar: String?
    var price: Int?
    var hotelImage: String?
    var hotelLocation: String?
    var hotelDesc: String?
    
    
    init(hotelName: String?,hotelStar: String?,price: Int?,hotelImage: String?,hotelLocation: String?,hotelDesc: String?) {
        super.init()
        self.hotelName = hotelName
        self.hotelStar = hotelStar
        self.price = price
        self.hotelImage = hotelImage
        self.hotelLocation = hotelLocation
        self.hotelDesc = hotelDesc
    }
    
}
