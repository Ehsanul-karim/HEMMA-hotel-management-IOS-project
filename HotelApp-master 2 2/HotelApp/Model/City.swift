//
//  BookingList.swift
//  HotelApp
//
//  Created by Biduit on 26/11/23.
//  Copyright © 2023 MACBOOK PRO RETINA. All rights reserved.
//

import UIKit

class City: NSObject {
    var name: String?
    var imageName: String?
    
     init(name: String?,imageName: String?) {
        super.init()
        self.name = name
        self.imageName = imageName
    }

}


