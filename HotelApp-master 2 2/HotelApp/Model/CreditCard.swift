//
//  BookingList.swift
//  HotelApp
//
//  Created by Biduit on 26/11/23.
//  Copyright © 2023 MACBOOK PRO RETINA. All rights reserved.
//
import UIKit

class CreditCard: NSObject {
    var cardNumber: String?
    var cardOwner: String?
    var issueDate: String?
    var expireDate: String?
    
    init(cardNumber: String?,cardOwner: String?,issueDate: String?,expireDate: String?) {
        super.init()
        self.cardNumber = cardNumber
        self.cardOwner = cardOwner
        self.issueDate = issueDate
        self.expireDate = expireDate
    }
}
