//
//  HomeViewController.swift
//  HotelApp
//
//  Created by Biduit on 26/11/23.
//  Copyright © 2023 MACBOOK PRO RETINA. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var searchTextField: UITextField = {
       let stf = UITextField()
        stf.placeholder = "Search"
        stf.borderStyle = .none
        stf.layer.cornerRadius = 30
        stf.clipsToBounds = true
        stf.setLeftPaddingPoints(20)
        stf.layer.borderWidth = 2
        stf.layer.borderColor = UIColor.orange.cgColor
        stf.translatesAutoresizingMaskIntoConstraints = false
        return stf
    }()
    
    var searchResultLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Nothing right now"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    var searchButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Search", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .orange
            button.layer.cornerRadius = 15
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
    
    let alphaView: UIView = {
        let av = UIView()
        av.backgroundColor = UIColor.init(white: 0.5, alpha: 0.5)
        av.translatesAutoresizingMaskIntoConstraints = false
        return av
    }()
    lazy var logoutView: LogoutView = {
        let lv = LogoutView()
        lv.translatesAutoresizingMaskIntoConstraints = false
        lv.homeViewController = self
        return lv
        }()
    var selectedItem: Int?
    var leftAnchor: NSLayoutConstraint?
    var rightAnchor: NSLayoutConstraint?
    var logoutTopAnchor: NSLayoutConstraint?
    var alphaViewTopAnchor: NSLayoutConstraint?
    lazy var navDrawerView : NavDrawerView = {
       let ndv = NavDrawerView()
       ndv.translatesAutoresizingMaskIntoConstraints = false
        ndv.homeViewController = self
        ndv.accountViewController = nil
        ndv.bookingViewController = nil
       return ndv
    }()
    
    lazy var closeDrawerView : CloseDrawerView = {
        let ndv = CloseDrawerView()
        ndv.translatesAutoresizingMaskIntoConstraints = false
        let viewTapped = UITapGestureRecognizer(target: self, action: #selector(closeNavDrawer))
        ndv.isUserInteractionEnabled = true
        ndv.addGestureRecognizer(viewTapped)
        return ndv
    }()
    
    var widthNavDrawer: CGFloat?
    var widthCloseNavDrawer: CGFloat?
    
     let currentWindow: UIWindow? = UIApplication.shared.keyWindow
    
    var recommendedHotels: [Hotel]?
    
    var passedHotel: Hotel? 
    
    lazy var cityCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
       let cvv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cvv.dataSource = self
        cvv.delegate = self
        cvv.translatesAutoresizingMaskIntoConstraints = false
        return cvv
    }()
    
    lazy var recommondedHotelView : RecommandedHotelView = {
       let rhv = RecommandedHotelView(frame: .zero)
        rhv.translatesAutoresizingMaskIntoConstraints = false
        rhv.homeViewController = self
        return rhv
    }()
    
    let cityId = "cityId"
    var cityArray: [City] = []
//    let cityArray = [City(name: "New York",imageName: "newyork"),City(name: "Paris",imageName: "paris"),City(name: "London",imageName: "london"),City(name: "Dubai",imageName: "dubai"),City(name: "London",imageName: "london"),City(name: "New York",imageName: "newyork")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gettingdata()
        setupView()
        setupConstraints()
        setupNavigationBar()
        setupActions()
    }
    
    func setupActions() {
            searchButton.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        }
    
    func gettingdata(){
        for hotel in recommondedHotelView.recommendedHotels{
            cityArray.append(City(
                name:hotel.hotelName,
                imageName: hotel.hotelImage
            ))
        }
    }
    
    func setupView() {
        view.addSubview(searchResultLabel)
        view.backgroundColor = UIColor.white
        view.addSubview(searchTextField)
        view.addSubview(cityCollectionView)
        view.addSubview(searchButton)
        view.addSubview(recommondedHotelView)
        //cityCollectionView.register(CityCollectionViewCell.self, forCellWithReuseIdentifier: cityId)
        //cityCollectionView.backgroundColor = UIColor.white
        currentWindow?.addSubview(navDrawerView)
        currentWindow?.addSubview(closeDrawerView)
        setupLogoutView()
        
    }
    
    func setupLogoutView() {
        currentWindow?.addSubview(alphaView)
        currentWindow?.addSubview(logoutView)
    }
    
    func setupLogoutViewConstraints() {
        currentWindow?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":alphaView]))
        alphaViewTopAnchor = alphaView.topAnchor.constraint(equalTo: (currentWindow?.topAnchor)!, constant: (currentWindow?.frame.height)!)
        alphaViewTopAnchor?.isActive = true
        alphaView.heightAnchor.constraint(equalTo: (currentWindow?.heightAnchor)!).isActive = true
        currentWindow?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[v0]-30-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":logoutView]))
        logoutView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        logoutTopAnchor = logoutView.centerYAnchor.constraint(equalTo: (currentWindow?.centerYAnchor)!, constant: (currentWindow?.frame.height)! )
        logoutTopAnchor?.isActive = true
    }
    
    func Logout() {
        alphaViewTopAnchor?.constant = (currentWindow?.frame.height)!
        logoutTopAnchor?.constant = (currentWindow?.frame.height)!
        self.currentWindow?.layoutIfNeeded()
        let signInViewController = SignInViewController()
        navigationController?.navigationBar.isHidden = true
        navigationController?.pushViewController(signInViewController, animated: false)
    }
    
    func cancelLogout() {
        alphaViewTopAnchor?.constant = (currentWindow?.frame.height)!
        logoutTopAnchor?.constant = (currentWindow?.frame.height)!
        self.currentWindow?.layoutIfNeeded()
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
                // Constraints for searchButton
                searchButton.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 20),
                searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                searchButton.widthAnchor.constraint(equalToConstant: 120),
                searchButton.heightAnchor.constraint(equalToConstant: 30),
                
                // Constraints for searchResultLabel
                searchResultLabel.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 20),
                searchResultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                searchResultLabel.widthAnchor.constraint(equalToConstant: 200),
                searchResultLabel.heightAnchor.constraint(equalToConstant: 30),
            ])
            
            // Add other constraints as before
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[v0]-20-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":searchTextField]))
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-84-[v0(60)]-20-[v1(110)]-20-[v2]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":searchTextField,"v1":cityCollectionView,"v2":recommondedHotelView]))
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[v0]-20-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":cityCollectionView]))
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[v0]-20-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":recommondedHotelView]))
        
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[v0]-20-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":searchTextField]))
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-84-[v0(60)]-20-[v1(110)]-20-[v2]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":searchTextField,"v1":cityCollectionView,"v2":recommondedHotelView]))
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[v0]-20-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":cityCollectionView]))
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[v0]-20-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":recommondedHotelView]))
        widthNavDrawer = (currentWindow?.frame.width)! * 2 / 3
        widthCloseNavDrawer = (currentWindow?.frame.width)! / 3
        navDrawerView.widthAnchor.constraint(equalToConstant: widthNavDrawer!).isActive = true
        navDrawerView.heightAnchor.constraint(equalTo: (currentWindow?.heightAnchor)!).isActive = true
       leftAnchor = navDrawerView.leftAnchor.constraint(equalTo: (currentWindow?.leftAnchor)!,constant: -widthNavDrawer!)
        leftAnchor?.isActive = true
        navDrawerView.topAnchor.constraint(equalTo: (currentWindow?.topAnchor)!).isActive = true
        closeDrawerView.widthAnchor.constraint(equalToConstant: widthCloseNavDrawer!).isActive = true
        closeDrawerView.heightAnchor.constraint(equalTo: (currentWindow?.heightAnchor)!).isActive = true
        rightAnchor = closeDrawerView.rightAnchor.constraint(equalTo: (currentWindow?.rightAnchor)!,constant: widthCloseNavDrawer!)
        rightAnchor?.isActive = true
        closeDrawerView.topAnchor.constraint(equalTo: (currentWindow?.topAnchor)!).isActive = true
        setupLogoutViewConstraints()
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Home"
        navigationController?.navigationBar.barTintColor = UIColor.orange
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(showNavigationDrawer))
        leftBarButtonItem.tintColor = UIColor.white
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "moree"), style: .plain, target: self, action: #selector(showNavigationDrawer))
        rightBarButtonItem.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc func searchButtonPressed() {
        guard let searchText = searchTextField.text, !searchText.isEmpty else {
                // Show an alert or handle the case when the search text is empty
                return
            }

//            let filteredCities = cityArray.filter { city in
//                if let hotelName = city.name, hotelName.lowercased().contains(searchText.lowercased()) {
//                    return true
//                }
//                return false
//            }

            searchResultLabel.text = "Search results for: \(searchText)"
            print(searchText)
            searchResultLabel.isHidden = false

//            cityArray = filteredCities
//
//            // Reload the collection view to display the matched hotels
//            cityCollectionView.reloadData()
        }
    
    @objc func showNavigationDrawer() {
        UIApplication.shared.keyWindow?.windowLevel = UIWindowLevelStatusBar
        leftAnchor?.constant = 0
        rightAnchor?.constant = 0
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.currentWindow?.layoutIfNeeded()
            self.currentWindow?.updateConstraints()
            self.currentWindow?.setNeedsLayout()
            self.view.layoutIfNeeded()
            self.view.setNeedsLayout()
        })
        
    }
    
    @objc func closeNavDrawer() {
        UIApplication.shared.keyWindow?.windowLevel = UIWindowLevelNormal
        leftAnchor?.constant = -widthNavDrawer!
        rightAnchor?.constant = widthCloseNavDrawer!
        self.currentWindow?.layoutIfNeeded()
        if selectedItem == 1 {
            let accountViewController = AccountViewController()
            navigationController?.pushViewController(accountViewController, animated: false)
        } else if selectedItem == 7 {
            alphaViewTopAnchor?.constant = 0
            logoutTopAnchor?.constant = 0
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
                self.currentWindow?.layoutIfNeeded()
            })
            
        } else if selectedItem == 2 {
            let bookingViewController = HistoryViewController()
            navigationController?.pushViewController(bookingViewController, animated: false)
        }
    }
    
    func displayDetailHotel() {
        let hotelDetailViewController = HotelDetailViewController()
        hotelDetailViewController.hotel = passedHotel
        navigationController?.pushViewController(hotelDetailViewController, animated: true)
    }
    
    func showMoreRecommendedHotels() {
        let moreHotelViewController = MoreHotelViewController()
        moreHotelViewController.recommendedHotels = recommendedHotels
        navigationController?.pushViewController(moreHotelViewController, animated: true)
    }
    
    

}

extension HomeViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cityArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cityCollectionView.dequeueReusableCell(withReuseIdentifier: cityId, for: indexPath) as! CityCollectionViewCell
        cell.city = cityArray[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 110)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
