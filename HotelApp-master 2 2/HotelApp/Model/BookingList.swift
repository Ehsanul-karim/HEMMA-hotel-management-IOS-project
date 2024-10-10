//
//  BookingList.swift
//  HotelApp
//
//  Created by Biduit on 26/11/23.
//  Copyright © 2023 MACBOOK PRO RETINA. All rights reserved.
//


import UIKit

class BookingList: NSObject {
    
    var user_name: String?
    var hotel_name: String?
    var night: Int?
    var room: Int?
    var dateOfArrival: String?
    var dateOfReturn: String?
    var price: Int?
    
    init(user_name: String?, hotel_name: String?, night: Int?, room: Int?, dateOfArrival: String?, dateOfReturn: String?, price: Int?) {
        super.init()
        self.user_name = user_name
        self.hotel_name = hotel_name
        self.night = night
        self.room = room
        self.dateOfArrival = dateOfArrival
        self.dateOfReturn = dateOfReturn
        self.price = price
    }
}
