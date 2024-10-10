import UIKit

class NightRoomView: UIView {
    
    let minusLabel: UILabel = {
        let ml = UILabel()
        ml.textAlignment = .center
        ml.textColor = UIColor.darkGray
        ml.translatesAutoresizingMaskIntoConstraints = false
        ml.font = UIFont.systemFont(ofSize: 20)
        ml.text = "-"
        return ml
    }()
    
    let plusLabel: UILabel = {
        let pl = UILabel()
        pl.textAlignment = .center
        pl.textColor = UIColor.darkGray
        pl.translatesAutoresizingMaskIntoConstraints = false
        pl.font = UIFont.systemFont(ofSize: 20)
        pl.text = "+"
        return pl
    }()
    
    let valueLabel: UILabel = {
        let pl = UILabel()
        pl.textAlignment = .center
        pl.textColor = UIColor.darkGray
        pl.translatesAutoresizingMaskIntoConstraints = false
        pl.font = UIFont.systemFont(ofSize: 20)
        pl.text = "1"
        return pl
    }()
    
    var value = 1 {
        didSet {
            valueLabel.text = "\(value)"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        setupGestures()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        addSubview(minusLabel)
        addSubview(plusLabel)
        addSubview(valueLabel)
    }
    
    func setupConstraints() {
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0(30)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": minusLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": minusLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v0(30)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": plusLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": plusLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0(40)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": valueLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": valueLabel]))
    }
    
    func setupGestures() {
        let minusTapGesture = UITapGestureRecognizer(target: self, action: #selector(minusTapped))
        minusLabel.isUserInteractionEnabled = true
        minusLabel.addGestureRecognizer(minusTapGesture)
        
        let plusTapGesture = UITapGestureRecognizer(target: self, action: #selector(plusTapped))
        plusLabel.isUserInteractionEnabled = true
        plusLabel.addGestureRecognizer(plusTapGesture)
    }
    
    @objc func minusTapped() {
        if value > 1 {
            value -= 1
        }
    }
    
    @objc func plusTapped() {
        value += 1
    }
}

