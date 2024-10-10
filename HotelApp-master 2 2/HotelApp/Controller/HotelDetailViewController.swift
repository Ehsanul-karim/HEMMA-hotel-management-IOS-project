//
//  HotelDetailViewController.swift
//  HotelApp
//
//  Created by Biduit on 26/11/23.
//  Copyright © 2023 MACBOOK PRO RETINA. All rights reserved.
//


import UIKit
import Firebase

class HotelDetailViewController: UIViewController {
    var user_name : String? = ""
    var night : Int? = 0
    var room:Int? = 0
    
    private func fetchUserDetailsAndUpdateLabels() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        

        ApiService.sharedInstance.fetchUserDetails(uid: uid) { [weak self] (user) in
            guard let user = user else {
                return
            }
            
            self!.user_name = user.full_name!
            
        }
    }
    
    
    var hotel: Hotel? {
        didSet {
            if let name = hotel?.hotelName {
            hotelNameLabel.text = name
            }
            if let price = hotel?.price {
                priceLabel.text = "\(price)"
            }
            if let hotel_description = hotel?.hotelDesc {
                hotelDescriptionLabel.text = hotel_description
            }
        
            if let hotelImageString = hotel?.hotelImage, let imageUrl = URL(string: hotelImageString) {
                hotelImagesView.imageURL = imageUrl
            } else {
                // Handle the case where hotelImage is nil
                // You can set a default image URL or perform any other appropriate action
                hotelImagesView.imageURL = URL(string: "https://images.trvl-media.com/lodging/1000000/10000/1200/1112/8e9d53b4.jpg?impolicy=resizecrop&rw=500&ra=fit")
            }

           
            if let numberOfStars = hotel?.hotelStar {
                hotelStarLabel.text = "\(numberOfStars) star hotel"
            }
        }
    }
    
    var hotelImagesView: HotelImagesView = {
       let hiv = HotelImagesView()
        hiv.translatesAutoresizingMaskIntoConstraints = false
        return hiv
    }()
    
    
    let priceLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor.orange
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let hotelNameLabel: UILabel = {
       let hnl = UILabel()
        hnl.textColor = UIColor.darkGray
        hnl.translatesAutoresizingMaskIntoConstraints = false
        hnl.font = UIFont.boldSystemFont(ofSize: 16)
        return hnl
    }()
    
    let hotelStarLabel: UILabel = {
        let hsl = UILabel()
        hsl.textColor = UIColor.init(white: 0.75, alpha: 1)
        hsl.translatesAutoresizingMaskIntoConstraints = false
        hsl.font = UIFont.systemFont(ofSize: 16)
        hsl.textAlignment = .right
        return hsl
    }()
    
    let hotelDescriptionLabel: UILabel = {
    let label = UILabel()
    label.textColor = UIColor.gray
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.boldSystemFont(ofSize: 14)
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    label.sizeToFit()
    return label
    }()
    
    let firstStarImageView: UIImageView = {
        let fsiv = UIImageView()
        fsiv.translatesAutoresizingMaskIntoConstraints = false
        fsiv.image = UIImage(named: "star")
        fsiv.contentMode = .scaleAspectFill
        fsiv.clipsToBounds = true
        return fsiv
    }()
    
    let secondStarImageView: UIImageView = {
        let fsiv = UIImageView()
        fsiv.translatesAutoresizingMaskIntoConstraints = false
        fsiv.image = UIImage(named: "star")
        fsiv.contentMode = .scaleAspectFill
        fsiv.clipsToBounds = true
        return fsiv
    }()
    
    let thirdStarImageView: UIImageView = {
        let fsiv = UIImageView()
        fsiv.translatesAutoresizingMaskIntoConstraints = false
        fsiv.image = UIImage(named: "star")
        fsiv.contentMode = .scaleAspectFill
        fsiv.clipsToBounds = true
        return fsiv
    }()
    
    let fourthStarImageView: UIImageView = {
        let fsiv = UIImageView()
        fsiv.translatesAutoresizingMaskIntoConstraints = false
        fsiv.image = UIImage(named: "star")
        fsiv.contentMode = .scaleAspectFill
        fsiv.clipsToBounds = true
        return fsiv
    }()
    
    let fiveStarImageView: UIImageView = {
        let fsiv = UIImageView()
        fsiv.translatesAutoresizingMaskIntoConstraints = false
        fsiv.image = UIImage(named: "star")
        fsiv.contentMode = .scaleAspectFill
        fsiv.clipsToBounds = true
        return fsiv
    }()
    
    let nightLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Nights"
        return label
   }()
    
    let roomLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Rooms"
        return label
   }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Arrival Date"
        return label
   }()
    
    let datePicker: UIDatePicker = {
            let picker = UIDatePicker()
            picker.datePickerMode = .date
            picker.translatesAutoresizingMaskIntoConstraints = false
            picker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
            return picker
        }()
    
    let dateLabel2: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Return Date"
        return label
   }()
    
    let datePicker2: UIDatePicker = {
            let picker = UIDatePicker()
            picker.datePickerMode = .date
            picker.translatesAutoresizingMaskIntoConstraints = false
            picker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
            return picker
        }()
    
    let nightIncrementView: NightRoomView = {
     let niv = NightRoomView()
     niv.translatesAutoresizingMaskIntoConstraints = false
     return niv
    }()
    
    

    // Function to create a date picke


    let roomIncrementView: NightRoomView = {
     let riv = NightRoomView()
     riv.translatesAutoresizingMaskIntoConstraints = false
     return riv
    }()
    
    let dateView: UIView = {
     let dv = UIView()
     //dv.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
     dv.translatesAutoresizingMaskIntoConstraints = false
     return dv
    }()
    
    let dateView2: UIView = {
     let dv2 = UIView()
     //dv.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
     dv2.translatesAutoresizingMaskIntoConstraints = false
     return dv2
    }()
    
    let bookButton: UIButton = {
        let button = UIButton()
        button.setTitle("Book Now", for: .normal)
        button.backgroundColor = UIColor.orange
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 30
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(BookAction), for: .touchUpInside)
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.date = Date()
        datePicker2.date = Date()
        setupNavigationBar()
        setupView()
        setupConstraints()
        fetchUserDetailsAndUpdateLabels()
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
    
    
    func setupView() {
    view.backgroundColor = UIColor.white
    //view.addSubview(datePicker)
        dateView.addSubview(datePicker)
        dateView2.addSubview(datePicker2)
    view.addSubview(hotelImagesView)
    view.addSubview(hotelNameLabel)
    view.addSubview(hotelStarLabel)
    view.addSubview(firstStarImageView)
    view.addSubview(secondStarImageView)
    view.addSubview(thirdStarImageView)
    view.addSubview(fourthStarImageView)
    view.addSubview(fiveStarImageView)
    view.addSubview(priceLabel)
    view.addSubview(hotelDescriptionLabel)
    view.addSubview(nightLabel)
    view.addSubview(roomLabel)
    view.addSubview(dateLabel)
    view.addSubview(dateLabel2)
    view.addSubview(nightIncrementView)
    view.addSubview(roomIncrementView)
    view.addSubview(dateView)
        view.addSubview(dateView2)
    //dateView.addSubview(valueDateLabel)
    view.addSubview(bookButton)
    setDate()
    }
    
    
    
    func setupNavigationBar() {
    navigationItem.title = "Hotel Details"
    }
    
    func setupConstraints() {
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]-10-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":hotelImagesView]))
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-74-[v0(\((view.frame.height - 114) / 2.8))]-20-[v1(20)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":hotelImagesView,"v1":hotelNameLabel]))
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0(250)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":hotelNameLabel]))
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v0(250)]-10-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":hotelStarLabel]))
            hotelStarLabel.topAnchor.constraint(equalTo: hotelImagesView.bottomAnchor,constant: 20).isActive = true
            hotelStarLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v0(10)]-5-[v1(10)]-5-[v2(10)]-5-[v3(10)]-5-[v4(10)]-20-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":firstStarImageView,"v1":secondStarImageView,"v2":thirdStarImageView,"v3":fourthStarImageView,"v4":fiveStarImageView]))
            firstStarImageView.topAnchor.constraint(equalTo: hotelStarLabel.bottomAnchor,constant: 10).isActive = true
            secondStarImageView.topAnchor.constraint(equalTo: firstStarImageView.topAnchor).isActive = true
            thirdStarImageView.topAnchor.constraint(equalTo: firstStarImageView.topAnchor).isActive = true
            fourthStarImageView.topAnchor.constraint(equalTo: firstStarImageView.topAnchor).isActive = true
            fiveStarImageView.topAnchor.constraint(equalTo: firstStarImageView.topAnchor).isActive = true
            priceLabel.topAnchor.constraint(equalTo: firstStarImageView.topAnchor).isActive = true
            firstStarImageView.heightAnchor.constraint(equalToConstant: 10).isActive = true
            secondStarImageView.heightAnchor.constraint(equalTo: firstStarImageView.heightAnchor).isActive = true
            thirdStarImageView.heightAnchor.constraint(equalTo: firstStarImageView.heightAnchor).isActive = true
            fourthStarImageView.heightAnchor.constraint(equalTo: firstStarImageView.heightAnchor).isActive = true
            fiveStarImageView.heightAnchor.constraint(equalTo: firstStarImageView.heightAnchor).isActive = true
            priceLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0(60)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":priceLabel]))
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]-10-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":hotelDescriptionLabel]))
            hotelDescriptionLabel.topAnchor.constraint(equalTo: firstStarImageView.bottomAnchor,constant: 5).isActive = true
            hotelDescriptionLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0(100)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":nightLabel]))
            nightLabel.topAnchor.constraint(equalTo: hotelDescriptionLabel.bottomAnchor).isActive = true
            nightLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
            roomLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            roomLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
            roomLabel.topAnchor.constraint(equalTo: nightLabel.topAnchor).isActive = true
            roomLabel.heightAnchor.constraint(equalTo: nightLabel.heightAnchor).isActive = true
            
            nightIncrementView.leftAnchor.constraint(equalTo: nightLabel.leftAnchor).isActive = true
            nightIncrementView.widthAnchor.constraint(equalToConstant: 60).isActive = true
            nightIncrementView.topAnchor.constraint(equalTo: nightLabel.bottomAnchor,constant: 10).isActive = true
            nightIncrementView.heightAnchor.constraint(equalToConstant: 20).isActive = true
            roomIncrementView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            roomIncrementView.widthAnchor.constraint(equalToConstant: 60).isActive = true
            roomIncrementView.topAnchor.constraint(equalTo: nightIncrementView.topAnchor).isActive = true
            roomIncrementView.heightAnchor.constraint(equalTo: nightIncrementView.heightAnchor).isActive = true
        
            dateLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
            dateLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
            dateLabel.topAnchor.constraint(equalTo: nightIncrementView.bottomAnchor).isActive = true
            dateLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
            dateView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
            dateView.widthAnchor.constraint(equalToConstant: 150).isActive = true
            dateView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor).isActive = true
            dateView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
            dateLabel2.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 250).isActive = true
            dateLabel2.widthAnchor.constraint(equalToConstant: 100).isActive = true
            dateLabel2.topAnchor.constraint(equalTo: roomIncrementView.bottomAnchor).isActive = true
            dateLabel2.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
            dateView2.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 250).isActive = true
            dateView2.widthAnchor.constraint(equalToConstant: 150).isActive = true
            dateView2.topAnchor.constraint(equalTo: dateLabel2.bottomAnchor).isActive = true
            dateView2.heightAnchor.constraint(equalToConstant: 60).isActive = true
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]-10-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":bookButton]))
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(60)]-30-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":bookButton]))

    }

    func setDate() {
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yyyy"
    //valueDateLabel.text = formatter.string(from: date)
    }

    @objc func BookAction() {
        if let booking = addbooking() {
                let paymentViewController = PaymentViewController()
                paymentViewController.booking = booking
                navigationController?.pushViewController(paymentViewController, animated: true)
            }
    }

    func addbooking() -> BookingList? {
        guard let fullName = user_name,
              let hotel_name = hotelNameLabel.text,
              let night = (nightIncrementView.valueLabel.text),
              let price = (priceLabel.text),
              let room = (roomIncrementView.valueLabel.text) else {
            return nil
        }
        let nightint = Int(night)!
        let roomint = Int(room)!
        let dateofArrival = datePicker.date
        let dateofReturn = datePicker2.date
        let priceint = Int(price)!
        let finalprice = priceint * roomint * nightint
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        
        let datearrivalString = dateFormatter.string(from: dateofArrival)
        let datereturnString = dateFormatter.string(from: dateofReturn)
        
        print("converted to string \(datereturnString)")
        
        let booking = BookingList(
            user_name: fullName,
            hotel_name: hotel_name,
            night: nightint,
            room: roomint,
            dateOfArrival: datearrivalString,
            dateOfReturn:  datereturnString,
            price:finalprice
        )
        
        return booking
    }

    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
            // Handle the date value change
            let selectedDate = sender.date
            print("Selected Date: \(selectedDate)")
        }
    
}
