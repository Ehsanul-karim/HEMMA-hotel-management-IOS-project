//
//  RecommandedHotelCollectionViewCell.swift
//  HotelApp
//
//  Created by Biduit on 26/11/23.
//  Copyright © 2023 MACBOOK PRO RETINA. All rights reserved.
//

import UIKit

class RecommandedHotelCollectionViewCell: UICollectionViewCell {
    
    var hotel: Hotel? {
        didSet {
            
            if let hotelName = hotel?.hotelName {
                recommendedHotelNameLabel.text = hotelName
            }
            if let price = hotel?.price {
                priceLabel.text = "\(price)$"
            }
            if let hotelImageString = hotel?.hotelImage, let imageUrl = URL(string: hotelImageString) {
                hotelImagesView.imageURL = imageUrl
            } else {
                // Handle the case where hotelImage is nil
                // You can set a default image URL or perform any other appropriate action
                hotelImagesView.imageURL = URL(string: "https://images.trvl-media.com/lodging/1000000/10000/1200/1112/8e9d53b4.jpg?impolicy=resizecrop&rw=500&ra=fit")
            }
        }
    }

    var hotelImagesView: HotelImagesView = {
       let hiv = HotelImagesView()
        hiv.contentMode = .scaleAspectFill
        hiv.clipsToBounds = true
        hiv.translatesAutoresizingMaskIntoConstraints = false
        return hiv
    }()

    
//    let recommendedHotelImageView: UIImageView = {
//        let recommendedHotelImageView = UIImageView()
//        recommendedHotelImageView.contentMode = .scaleAspectFill
//        recommendedHotelImageView.clipsToBounds = true
//        recommendedHotelImageView.translatesAutoresizingMaskIntoConstraints = false
//        return recommendedHotelImageView
//    }()
    
    let recommendedHotelNameLabel: UILabel = {
       let rhnl = UILabel()
        rhnl.translatesAutoresizingMaskIntoConstraints = false
        rhnl.textColor = UIColor.white
        rhnl.font = UIFont.boldSystemFont(ofSize: 16)
        return rhnl
    }()
    
    let priceLabel: UILabel = {
        let rhnl = UILabel()
        rhnl.translatesAutoresizingMaskIntoConstraints = false
        rhnl.textColor = UIColor.white
        rhnl.font = UIFont.systemFont(ofSize: 14)
        return rhnl
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
//       addSubview(recommendedHotelImageView)
        //addSubview(hotelImagesView)
        addSubview(hotelImagesView)
        addSubview(recommendedHotelNameLabel)
        addSubview(priceLabel)
    }
    
    func setupConstraints() {
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":recommendedHotelImageView]))
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":recommendedHotelImageView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":recommendedHotelNameLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(20)]-5-[v1(20)]-15-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":recommendedHotelNameLabel,"v1":priceLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":priceLabel]))
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]-10-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":hotelImagesView]))
        
                addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":hotelImagesView]))
                addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":hotelImagesView]))
    }
    
}
