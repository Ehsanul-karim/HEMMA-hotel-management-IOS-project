import UIKit
import FirebaseDatabase
import FirebaseAuth

class HistoryViewController: UIViewController {

    var bookingHistory: [BookingList] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        tableView.dataSource = self
        tableView.delegate = self

        // Register the custom cell
        tableView.register(BookingCell.self, forCellReuseIdentifier: "BookingCell")

        // Load booking history data from Firebase
        loadBookingHistoryFromFirebase()
    }

    func loadBookingHistoryFromFirebase() {
        // Assuming you have a reference to your Firebase database
        let databaseRef = Database.database().reference()

        // Replace "uid" with the actual user ID
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }

        let userBookingsRef = databaseRef.child("bookings").child(uid)

        // Observe changes in the database
        userBookingsRef.observe(.value) { [weak self] snapshot in
            guard let self = self else { return }

            var bookings: [BookingList] = []

            for child in snapshot.children {
                guard let snapshot = child as? DataSnapshot,
                      let bookingDict = snapshot.value as? [String: Any] else {
                    continue
                }

                let booking = BookingList(
                    user_name: bookingDict["user_name"] as? String ?? "",
                    hotel_name: bookingDict["hotel_name"] as? String ?? "",
                    night: bookingDict["night"] as? Int ?? 0,
                    room: bookingDict["room"] as? Int ?? 0,
                    dateOfArrival: bookingDict["dateOfArrival"] as? String ?? "",
                    dateOfReturn: bookingDict["dateOfReturn"] as? String ?? "",
                    price: bookingDict["price"] as? Int ?? 0
                )

                bookings.append(booking)
//                print("user_name \(booking.user_name)")
//                print("hotel_name \(booking.hotel_name)")
//                print("price \(booking.price)")
            }

            self.bookingHistory = bookings
        }




        
    }
}

extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookingHistory.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingCell", for: indexPath) as! BookingCell
        let booking = bookingHistory[indexPath.row]
        cell.configure(with: booking)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Handle row selection if needed
    }
}

