//
//  AccountView.swift
//  HotelApp
//
//  Created by Biduit on 26/11/23.
//  Copyright © 2023 MACBOOK PRO RETINA. All rights reserved.
//

import UIKit
import Firebase

class AccountView: UIView, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    private func fetchUserDetailsAndUpdateLabels() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let databaseRef = Database.database().reference().child("users").child(uid)
                
                // Fetch user details from the database
                databaseRef.observeSingleEvent(of: .value) { [weak self] (snapshot) in
                    guard let userData = snapshot.value as? [String: Any] else {
                        return
                    }
                    
                    // Update labels with user information
                    self?.fullNameTf.text = userData["full_name"] as? String ?? ""
                    self?.mailTf.text = userData["email"] as? String ?? ""
                    self?.phoneTf.text = userData["phone_number"] as? String ?? ""
                }
        ApiService.sharedInstance.fetchUserDetails(uid: uid) { [weak self] (user) in
            guard let user = user else {
                return
            }
            
            // Update labels with user information
            self?.fullNameTf.text = user.full_name
            self?.mailTf.text = user.email
            self?.phoneTf.text = user.phone_number
        }
    }
    
    var profileImgView : UIImageView = {
        let piv = UIImageView()
        piv.image = UIImage(named: "no-profil")
        piv.contentMode = .scaleToFill
        piv.clipsToBounds = true
        piv.translatesAutoresizingMaskIntoConstraints = false
        return piv
    }()
    
    lazy var cameraImgView: UIImageView = {
        let civ = UIImageView()
        civ.image = UIImage(named: "camera")
        civ.tintColor = UIColor.white
        civ.contentMode = .scaleToFill
        civ.clipsToBounds = true
        civ.translatesAutoresizingMaskIntoConstraints = false
        let imgTapped = UITapGestureRecognizer(target: self, action: #selector(cameraImgTapped))
        civ.isUserInteractionEnabled = true
        civ.addGestureRecognizer(imgTapped)
        return civ
    }()
    
    let fullNameLabel: UILabel = {
        let cnl = UILabel()
        cnl.textColor = UIColor.darkGray
        cnl.text = "Full Name"
        cnl.font = UIFont.systemFont(ofSize: 13)
        cnl.translatesAutoresizingMaskIntoConstraints = false
        return cnl
    }()
    
    let fullNameTf: UITextField = {
        let cnl = UITextField()
        cnl.textColor = UIColor.darkGray
        cnl.text = ""
        cnl.borderStyle = .none
        cnl.font = UIFont.boldSystemFont(ofSize: 15)
        cnl.translatesAutoresizingMaskIntoConstraints = false
        return cnl
    }()
    
    let fullNameView: UIView = {
        let cnv = UIView()
        cnv.backgroundColor = UIColor.init(white: 0.9, alpha: 1)
        cnv.translatesAutoresizingMaskIntoConstraints = false
        return cnv
    }()
    
    let mailLabel: UILabel = {
        let cnl = UILabel()
        cnl.textColor = UIColor.darkGray
        cnl.text = "Email"
        cnl.font = UIFont.systemFont(ofSize: 13)
        cnl.translatesAutoresizingMaskIntoConstraints = false
        return cnl
    }()
    
    let mailTf: UITextField = {
        let cnl = UITextField()
        cnl.textColor = UIColor.darkGray
        cnl.text = ""
        cnl.borderStyle = .none
        cnl.font = UIFont.boldSystemFont(ofSize: 15)
        cnl.translatesAutoresizingMaskIntoConstraints = false
        return cnl
    }()
    
    let mailView: UIView = {
        let cnv = UIView()
        cnv.backgroundColor = UIColor.init(white: 0.9, alpha: 1)
        cnv.translatesAutoresizingMaskIntoConstraints = false
        return cnv
    }()
    
    let phoneLabel: UILabel = {
        let cnl = UILabel()
        cnl.textColor = UIColor.darkGray
        cnl.text = "Phone Number"
        cnl.font = UIFont.systemFont(ofSize: 13)
        cnl.translatesAutoresizingMaskIntoConstraints = false
        return cnl
    }()
    
    let phoneTf: UITextField = {
        let cnl = UITextField()
        cnl.textColor = UIColor.darkGray
        cnl.text = ""
        cnl.borderStyle = .none
        cnl.font = UIFont.boldSystemFont(ofSize: 15)
        cnl.translatesAutoresizingMaskIntoConstraints = false
        return cnl
    }()
    
    let phoneView: UIView = {
        let cnv = UIView()
        cnv.backgroundColor = UIColor.init(white: 0.9, alpha: 1)
        cnv.translatesAutoresizingMaskIntoConstraints = false
        return cnv
    }()
    
    let saveChangesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save Changes", for: .normal)
        button.backgroundColor = UIColor.orange
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 30
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(saveChangeAction), for: .touchUpInside)
        return button
    }()
    
    lazy var imagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        return imagePicker
    }()
    var accountViewController: AccountViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(profileImgView)
        addSubview(cameraImgView)
        addSubview(fullNameLabel)
        addSubview(fullNameTf)
        addSubview(fullNameView)
        addSubview(mailLabel)
        addSubview(mailTf)
        addSubview(mailView)
        addSubview(phoneLabel)
        addSubview(phoneTf)
        addSubview(phoneView)
        fetchUserDetailsAndUpdateLabels()
        addSubview(saveChangesButton)
    }
    
    func setupConstraints() {
        let safeArea = self.safeAreaLayoutGuide

        addConstraints([
            // Profile Image
            profileImgView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            profileImgView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            profileImgView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            profileImgView.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.height - 64) / 3),
            
            // Camera Image
            cameraImgView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: ((UIScreen.main.bounds.height - 64) / 3) - 55),
            cameraImgView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            cameraImgView.widthAnchor.constraint(equalToConstant: 30),
            cameraImgView.heightAnchor.constraint(equalToConstant: 30),
            
            // Full Name Label
            fullNameLabel.topAnchor.constraint(equalTo: profileImgView.bottomAnchor, constant: 10),
            fullNameLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            fullNameLabel.widthAnchor.constraint(equalToConstant: 150),
            
            // Full Name TextField
            fullNameTf.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 5),
            fullNameTf.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            fullNameTf.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            fullNameTf.heightAnchor.constraint(equalToConstant: 20),
            
            // Full Name View
            fullNameView.topAnchor.constraint(equalTo: fullNameTf.bottomAnchor, constant: 5),
            fullNameView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            fullNameView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            fullNameView.heightAnchor.constraint(equalToConstant: 2),
            
            // Mail Label
            mailLabel.topAnchor.constraint(equalTo: fullNameView.bottomAnchor, constant: 10),
            mailLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            mailLabel.widthAnchor.constraint(equalToConstant: 150),
            
            // Mail TextField
            mailTf.topAnchor.constraint(equalTo: mailLabel.bottomAnchor, constant: 5),
            mailTf.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            mailTf.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            mailTf.heightAnchor.constraint(equalToConstant: 20),
            
            // Mail View
            mailView.topAnchor.constraint(equalTo: mailTf.bottomAnchor, constant: 5),
            mailView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            mailView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            mailView.heightAnchor.constraint(equalToConstant: 2),
            
            // Phone Label
            phoneLabel.topAnchor.constraint(equalTo: mailView.bottomAnchor, constant: 10),
            phoneLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            phoneLabel.widthAnchor.constraint(equalToConstant: 150),
            
            // Phone TextField
            phoneTf.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 5),
            phoneTf.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            phoneTf.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            phoneTf.heightAnchor.constraint(equalToConstant: 20),
            
            // Phone View
            phoneView.topAnchor.constraint(equalTo: phoneTf.bottomAnchor, constant: 5),
            phoneView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            phoneView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            phoneView.heightAnchor.constraint(equalToConstant: 2),
            
            // Save Changes Button
            saveChangesButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -30),
            saveChangesButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            saveChangesButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            saveChangesButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }

    
    @objc func cameraImgTapped() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            accountViewController?.present(imagePicker, animated: true, completion: nil)
            
        }
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        accountViewController?.dismiss(animated: true, completion: { () -> Void in
        })
        profileImgView.image = image
    }
    
    @objc func saveChangeAction() {
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        ApiService.sharedInstance.fetchUserDetails(uid: uid) { [weak self] (user) in
            guard let user = user else {
                return
            }
            // Update the profile picture URL in the user object
            //            user.updateProfilePicture(url: imageUrl)
            
            // Now you can save or update the user object in your database
            // (e.g., Firestore or any other database service)
            // Example:
            let databaseRef = Database.database().reference().child("users").child(uid)
                        
                        var updatedUserData: [String: Any] = [
                            "full_name": user.full_name ?? "",
                            "email": user.email ?? "",
                            "phone_number": user.phone_number ?? "",
                            // Add other fields as needed
                        ]
            
            updatedUserData["full_name"] = self?.fullNameTf.text
            updatedUserData["email"] = self?.mailTf.text
            updatedUserData["phone_number"] = self?.phoneTf.text
            print(updatedUserData)
            
            databaseRef.updateChildValues(updatedUserData) { (error, _) in
                            if let error = error {
                                print("Failed to update user profile: \(error.localizedDescription)")
                            } else {
                                print("User profile updated successfully")
                            }
                        }
        }
    }
}
