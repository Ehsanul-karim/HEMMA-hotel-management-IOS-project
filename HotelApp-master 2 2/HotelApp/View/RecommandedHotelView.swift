//
//  RecommandedHotelView.swift
//  HotelApp
//
//  Created by Biduit on 26/11/23.
//  Copyright © 2023 MACBOOK PRO RETINA. All rights reserved.
//

import UIKit

class RecommandedHotelView: UIView {
    
    let recommendedCellId = "recommendedCellId"
    let recommendedHotelLabel: UILabel = {
       let rhv = UILabel()
        rhv.text = "Recommended Hotels"
        rhv.textColor = UIColor.darkGray
        rhv.translatesAutoresizingMaskIntoConstraints = false
        rhv.font = UIFont.boldSystemFont(ofSize: 16)
        return rhv
    }()
    
    var homeViewController: HomeViewController?
    
    lazy var ViewMoreLabel: UILabel = {
        let vml = UILabel()
        vml.text = "View More"
        vml.textColor = UIColor.darkGray
        vml.translatesAutoresizingMaskIntoConstraints = false
        vml.font = UIFont.systemFont(ofSize: 13)
        vml.textAlignment = .right
        let labelTapped = UITapGestureRecognizer(target: self, action: #selector(ViewMoreTapped))
        vml.isUserInteractionEnabled = true
        vml.addGestureRecognizer(labelTapped)
        return vml
    }()
    
    lazy var recommendedHotelCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
       let rhcv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        rhcv.translatesAutoresizingMaskIntoConstraints = false
        rhcv.delegate = self
        rhcv.dataSource = self
        rhcv.backgroundColor = UIColor.white
        return rhcv
    }()
    
    var recommendedHotels: [Hotel] = []
    
    
    
    func fetchHotelDetails(num: Int, completion: @escaping () -> Void) {
            // Make API request to fetch hotel details
        
        let headers = [
            "X-RapidAPI-Key": "0ccbe60397msh096387a345dd927p1b498ejsn4a88bab12412",
            "X-RapidAPI-Host": "hotels-com-provider.p.rapidapi.com"
        ]
            
            let request = NSMutableURLRequest(url: NSURL(string: "https://hotels-com-provider.p.rapidapi.com/v2/hotels/summary?hotel_id=\(num)&locale=en_GB&domain=AE")! as URL,
                                                    cachePolicy: .useProtocolCachePolicy,
                                                timeoutInterval: 10.0)
            
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers

            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                } else if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let hotelData = try decoder.decode(HotelDetails.self, from: data)
                        
                        // Assuming "hotel_description" is a key in the JSON response
                        let hotelName = hotelData.summary?.name
                        let hotelStar = hotelData.reviewInfo?.summary?.overallScoreWithDescriptionA11y?.value
                        let hotelImage = hotelData.propertyGallery?.images?.first?.image?.url
                        let hotelDesc = hotelData.summary?.location?.whatsAround?.editorial?.content
                        let hotelLocation = hotelData.summary?.location?.address?.addressLine
                        
                        print("hotel name is \(hotelName)")
                        
                        let hotel_final_image = hotelImage ?? "https://mlx3lspc9ed5.i.optimole.com/cb:GgYV.35093/w:1100/h:618/q:mauto/f:best/https://www.bluehost.com/blog/wp-content/uploads/2023/07/What-is-a-404-error-code.png"
                            
                        // Perform UI updates on the main thread
                        DispatchQueue.main.async {
                            let myHotel = Hotel(
                                hotelName: hotelName,
                                hotelStar: hotelStar,
                                price: Int.random(in: 100..<1000),
                                hotelImage: hotel_final_image,
                                hotelLocation: hotelLocation,
                                hotelDesc: hotelDesc?.first
                            )
//                            print("my hotels name \(myHotel.hotelName)")
//                            print("my hotels star \(myHotel.hotelStar)")
//                            print("my hotels price \(myHotel.price)")
//                            print("my hotels image \(myHotel.hotelImage)")
//                            print("my hotels location \(myHotel.hotelLocation)")
//                            print("my hotels desc \(myHotel.hotelDesc)")
                            self.recommendedHotels.append(myHotel)
                            completion()
                            // Update the hotelDescriptionLabel with the received data
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                } else {
                    print("No data received.")
                }
            }

            dataTask.resume()
        }
    
    func fetchHotelDetailsInRange(start: Int, end: Int, completion: @escaping () -> Void) {
            let dispatchGroup = DispatchGroup()

            for number in start...end {
                dispatchGroup.enter()

                DispatchQueue.global().async {
                    self.fetchHotelDetails(num: number) {
                        dispatchGroup.leave()
                    }
                }
            }

            dispatchGroup.notify(queue: .main) {
                // All hotel details have been fetched, call the completion handler
                completion()
            }
        }
    func fetchAllHotelDetails() {
            let dispatchGroup = DispatchGroup()

            for number in 1105156...1105158 {
                dispatchGroup.enter()

                DispatchQueue.global().async {
                    self.fetchHotelDetails(num: number) {
                        dispatchGroup.leave()
                    }
                }
            }

            dispatchGroup.notify(queue: .main) {
                // All hotel details have been fetched, reload the collection view
                self.setupView()
                self.setupConstraints()
                self.recommendedHotelCollectionView.reloadData()
            }
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //Remind me to uncomment this line
        
        fetchAllHotelDetails()
//        setupView()
//        setupConstraints()
//        fetchHotelDetailsInRange(start: 1112, end: 1113) {
//                    self.setupView()
//                    self.setupConstraints()
//                    self.recommendedHotelCollectionView.reloadData()
//                }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(recommendedHotelLabel)
        addSubview(ViewMoreLabel)
        addSubview(recommendedHotelCollectionView)
        recommendedHotelCollectionView.register(RecommandedHotelCollectionViewCell.self, forCellWithReuseIdentifier: recommendedCellId)
    }
    
    func setupConstraints() {
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":recommendedHotelLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0(30)]-20-[v1]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":recommendedHotelLabel,"v1":recommendedHotelCollectionView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v0(100)]-10-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":ViewMoreLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0(30)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":ViewMoreLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":recommendedHotelCollectionView]))
    }
    
    
    
}

extension RecommandedHotelView: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: recommendedCellId, for: indexPath) as! RecommandedHotelCollectionViewCell
        print(indexPath)
        cell.hotel = recommendedHotels[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        homeViewController?.passedHotel = recommendedHotels[indexPath.item]
        homeViewController?.displayDetailHotel()
    }
    
    @objc func ViewMoreTapped() {
        homeViewController?.recommendedHotels = recommendedHotels
        homeViewController?.showMoreRecommendedHotels()
    }
}

