//
//  NavDrawerView.swift
//  HotelApp
//
//  Created by Biduit on 26/11/23.
//  Copyright © 2023 MACBOOK PRO RETINA. All rights reserved.
//
import UIKit
import Firebase

class NavDrawerView: UIView {
    
    

    private func fetchUserDetailsAndUpdateLabels() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        

        ApiService.sharedInstance.fetchUserDetails(uid: uid) { [weak self] (user) in
            guard let user = user else {
                return
            }

            // Update labels with user information
            self?.nameLabel.text = user.full_name
            self?.mailLabel.text = user.email
        }
    }
    
    let navDrawerCvId = "navDrawerCvId"
    var homeViewController: HomeViewController?
    var bookingViewController: BookingViewController?
    var accountViewController: AccountViewController?
    var historyViewController: HistoryViewController?
    let menuItems = [
        Menu(name: "Home", imageName: "home"),
        Menu(name: "Account", imageName: "account"),
        Menu(name: "History", imageName: "account"),
        Menu(name: "Logout", imageName: "logout")
    ]
    
    
    var headerView: UIView = {
        var hv = UIView()
        hv.backgroundColor = UIColor.orange
        hv.translatesAutoresizingMaskIntoConstraints = false
        return hv
    }()
    
    let profileImgView: UIImageView = {
       let piv = UIImageView()
        piv.image = UIImage(named: "no-profil")
        piv.contentMode = .scaleToFill
        piv.clipsToBounds = true
        piv.layer.cornerRadius = 30
        piv.translatesAutoresizingMaskIntoConstraints = false
        return piv
    }()
    
    let nameLabel: UILabel = {
       let nl = UILabel()
        nl.text = ""
        nl.textColor = UIColor.white
        nl.font = UIFont.boldSystemFont(ofSize: 16)
        nl.translatesAutoresizingMaskIntoConstraints = false
        return nl
    }()
    
    let mailLabel: UILabel = {
        let nl = UILabel()
        nl.text = ""
        nl.textColor = UIColor.white
        nl.font = UIFont.systemFont(ofSize: 14)
        nl.translatesAutoresizingMaskIntoConstraints = false
        return nl
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
       let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = UIColor.white
       cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = UIColor.white
        addSubview(headerView)
        headerView.addSubview(profileImgView)
        headerView.addSubview(nameLabel)
        headerView.addSubview(mailLabel)
        collectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: navDrawerCvId)
        addSubview(collectionView)
        fetchUserDetailsAndUpdateLabels()
    }
    
    func setupConstraints() {
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":headerView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0(176)]-10-[v1]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":headerView,"v1":collectionView]))
        headerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-30-[v0(60)]-10-[v1(20)]-10-[v2(20)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":profileImgView,"v1":nameLabel,"v2":mailLabel]))
        headerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[v0(60)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":profileImgView]))
        headerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[v0(150)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":nameLabel]))
        headerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[v0(200)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":mailLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":collectionView]))
    }

}

extension NavDrawerView: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: navDrawerCvId, for: indexPath) as! MenuCollectionViewCell
        cell.menu = menuItems[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if menuItems[indexPath.item].name == "Logout" {
            // Show logout confirmation
            showLogoutConfirmation()
        } else {
            // Handle other menu item selections
            handleMenuItemSelection(at: indexPath.item)
        }
    }
    private func handleMenuItemSelection(at index: Int) {
        if homeViewController != nil {
            homeViewController?.selectedItem = index
            homeViewController?.closeNavDrawer()
        } else if accountViewController != nil {
            accountViewController?.selectedItem = index
            accountViewController?.closeNavDrawer()
        } else if bookingViewController != nil {
            bookingViewController?.selectedItem = index
            bookingViewController?.closeNavDrawer()
        } else {
            print("all vc are nil")
        }
    }
    private func showLogoutConfirmation() {
        let alertController = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        let logoutAction = UIAlertAction(title: "Logout", style: .destructive) { [weak self] (_) in
            // Perform logout actions
            self?.performLogout()
        }
        alertController.addAction(logoutAction)

        // Present the alert controller
        if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
            rootViewController.present(alertController, animated: true, completion: nil)
        }
    }
    

    
    private func performLogout() {
        // Implement your logout logic here
        // For example, sign out the user from Firebase
        do {
            if homeViewController != nil {
                homeViewController?.Logout()
            }
            try Auth.auth().signOut()
            // Redirect to the login screen or perform any additional actions
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError.localizedDescription)")
        }
    }
}

