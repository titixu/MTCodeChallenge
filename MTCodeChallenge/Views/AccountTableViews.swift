//  Copyright © 2019 Sam Xu. All rights reserved.
//

import UIKit

// show in the top of account view,
// it will get insert into account table view as tableHeaderView
class  AccountHeaderView: UIView {
    // use to define which view layout
    var isForeignAccountType = false
    
    var nicknameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textColor
        label.text = "Nick name" // add default value, easier for testing
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    var amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textColor
        label.text = "JPY12000"
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        return label
    }()
    
    // only shown when account type is foreign
    var secondaryAmountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textColor
        label.text = "JPY12000"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    // display monthly money in amount
    var moneyInLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textColor
        label.text = "in JPY1000"
        label.textAlignment = .right
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    // display monthly money out amount
    var moneyOutLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textColor
        label.text = "out JPY1000"
        label.textAlignment = .right
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    init(isForeignAccountType: Bool, frame: CGRect) {
        self.isForeignAccountType = isForeignAccountType
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.backgroundColor = .appBackground
        
        // contain the monthly money in and out labels
        let moneyInOutStackView = UIStackView(arrangedSubviews: [moneyInLabel, moneyOutLabel])
        moneyInOutStackView.axis = .vertical
        
        // contain the account amount label and local currency amount label
        let amountStackView = UIStackView(arrangedSubviews: [amountLabel, secondaryAmountLabel])
        amountStackView.axis = .vertical
        
        // contain the bottom part of the views
        let bottomStackView = UIStackView(arrangedSubviews: [amountStackView, moneyInOutStackView])
        
        // contain all subviews
        let containerStackView = UIStackView(arrangedSubviews: [nicknameLabel, bottomStackView])
        containerStackView.axis = .vertical
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(containerStackView)
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: topAnchor, constant: .padding),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .padding),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.padding),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.padding)
            ])
        
    }
}

class TransactionCell: AccountCell {
    // show the date for excample 26
    var dayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textColor
        label.text = "26"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    override func setupViews() {
        backgroundColor = .clear
        let stackView = UIStackView(arrangedSubviews: [dayLabel, nicknameLabel, amountLabel])
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .padding),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.padding)
            ])
    }
    
}
