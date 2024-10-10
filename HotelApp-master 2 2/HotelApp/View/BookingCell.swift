import UIKit

class BookingCell: UITableViewCell {

    let userLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let hotelLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let nightLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let roomLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let arrivalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let returnLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    private func setupUI() {
        addSubview(userLabel)
        addSubview(hotelLabel)
        addSubview(nightLabel)
        addSubview(roomLabel)
        addSubview(arrivalLabel)
        addSubview(returnLabel)
        addSubview(priceLabel)

        NSLayoutConstraint.activate([
            userLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            userLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            userLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            hotelLabel.topAnchor.constraint(equalTo: userLabel.bottomAnchor, constant: 4),
            hotelLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            hotelLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            nightLabel.topAnchor.constraint(equalTo: hotelLabel.bottomAnchor, constant: 4),
            nightLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nightLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            roomLabel.topAnchor.constraint(equalTo: nightLabel.bottomAnchor, constant: 4),
            roomLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            roomLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            arrivalLabel.topAnchor.constraint(equalTo: roomLabel.bottomAnchor, constant: 4),
            arrivalLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            arrivalLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            returnLabel.topAnchor.constraint(equalTo: arrivalLabel.bottomAnchor, constant: 4),
            returnLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            returnLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            priceLabel.topAnchor.constraint(equalTo: returnLabel.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }

    func configure(with booking: BookingList) {
        userLabel.text = "User: \(booking.user_name ?? "")"
        hotelLabel.text = "Hotel: \(booking.hotel_name ?? "")"
        nightLabel.text = "Nights: \(booking.night ?? 0)"
        roomLabel.text = "Rooms: \(booking.room ?? 0)"
        arrivalLabel.text = "Arrival: \(booking.dateOfArrival ?? "")"
        returnLabel.text = "Return: \(booking.dateOfReturn ?? "")"
        priceLabel.text = "Price: $\(booking.price ?? 0)"
    }
}

