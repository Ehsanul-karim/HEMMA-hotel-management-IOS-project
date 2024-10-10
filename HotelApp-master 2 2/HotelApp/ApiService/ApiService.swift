//
//  ApiService.swift
//  HotelApp
//
//  Created by Omar Thamri on 07/07/2019.
//  Copyright © 2019 MACBOOK PRO RETINA. All rights reserved.
//

import UIKit
import CoreData
import Firebase

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()

    func fetchUserDetails(uid: String, completion: @escaping (User?) -> Void) {
         let usersRef = Database.database().reference().child("users").child(uid)
        usersRef.observeSingleEvent(of: .value) { (snapshot) in
             guard let userData = snapshot.value as? [String: Any] else {
                 completion(nil)
                 return
             }

             let user = User(
                 full_name: userData["full_name"] as? String,
                 email: userData["email"] as? String,
                 phone_number: userData["phone_number"] as? String,
                 password: userData["password"] as? String
             )

             completion(user)
         }
     }
    
    func saveUser(uid: String, user: User) {
            let usersRef = Database.database().reference().child("users").child(uid)
            usersRef.setValue(["full_name": user.full_name,
                               "email": user.email,
                               "phone_number": user.phone_number,
                               "password": user.password])
        }
    
    func updateProfile(uid: String, full_name: String, email: String, phone_number: String, completion: @escaping (Bool) -> Void) {
        let usersRef = Database.database().reference().child("users").child(uid)
        let userData: [String: Any] = [
            "full_name": full_name,
            "email": email,
            "phone_number": phone_number,
        ]

        usersRef.updateChildValues(userData) { (error, _) in
            if let error = error {
                print("Error updating profile: \(error.localizedDescription)")
                completion(false)
            } else {
                print("DID IT SUCCESSFULLY")
                completion(true)
            }
        }
    }
}
