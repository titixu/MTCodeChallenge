//  Copyright © 2019 Sam Xu. All rights reserved.
//

// this files contains all the views and cells needed for AccountViewController

import UIKit

// show in the top of account view,
// it will get insert into account table view as tableHeaderView
class  AccountHeaderView: UIView {

    var nicknameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textColor
        label.text = "Nick name" // add default value, easier for testing
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.accessibilityValue = "Nickname"
        return label
    }()
    
    var amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textColor
        label.text = "JPY12000"
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.accessibilityValue = "Total amount in the account or card"
        return label
    }()
    
    // only shown when account type is foreign
    var secondaryAmountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textColor
        label.text = "JPY12000"
        label.accessibilityValue = "Total amount in the account or card"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    // display monthly money in amount
    var moneyInLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textColor
        label.text = "in JPY1000"
        label.accessibilityValue = "deposit"
        label.textAlignment = .right
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    // display monthly money out amount
    var moneyOutLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textColor
        label.text = "out JPY1000"
        label.accessibilityValue = "withdraw"
        label.textAlignment = .right
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    var viewModel: AccountHeaderViewModel? {
        didSet {
            // force the view to refresh after view model is set/updated
            // layoutSubviews() will get called after setNeedsLayout() got called
            setNeedsLayout()
        }
    }
    
    init(viewModel: AccountHeaderViewModel?, frame: CGRect) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        let spacing: CGFloat = 5.0
        
        self.backgroundColor = .appBackground
        
        // contain the monthly money in and out labels
        let moneyInOutStackView = UIStackView(arrangedSubviews: [moneyInLabel, moneyOutLabel])
        moneyInOutStackView.axis = .vertical
        moneyInOutStackView.spacing = spacing
        
        // contain the account amount label and local currency amount label
        let amountStackView = UIStackView(arrangedSubviews: [amountLabel, secondaryAmountLabel])
        amountStackView.axis = .vertical
        amountStackView.spacing = spacing
        
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
    
    override func layoutSubviews() {
        if let viewModel = viewModel {
            nicknameLabel.text = viewModel.nickName
            amountLabel.text = viewModel.amount
            moneyInLabel.text = viewModel.inAmount
            moneyOutLabel.text = viewModel.outAmount
            secondaryAmountLabel.text = viewModel.amountInBase
            secondaryAmountLabel.isHidden = !viewModel.showAmountInBase
        }
        super.layoutSubviews()
    }
    
}

// the table cell for the AccountViewController
class TransactionCell: UITableViewCell {
    
    // show the description of the transaction
    var descirptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textColor
        // using more than one line when the description is too long
        // but limited to the cell height
        label.numberOfLines = 0
        // it can be compressed when desctription is too long
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.accessibilityValue = "Transaction description"
        return label
    }()
    
    // show the amount of the transaction
    var amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textColor
        label.textAlignment = .right
        // daylabel doesn't need a lot of space to display, shorten the width
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.accessibilityValue = "Tansaction amount"
        return label
    }()
    
    // show the date for excample 26
    var dayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textColor
        label.text = "26"
        // daylabel doesn't need a lot of space to display, shorten the width
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.accessibilityValue = "Transaction day"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        backgroundColor = .clear
        let stackView = UIStackView(arrangedSubviews: [dayLabel, descirptionLabel, amountLabel])
        stackView.spacing = .padding
        stackView.alignment = .center
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

// a badge label with corner radius
// it is for account section header view
class BadgeLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = .textColor
        font = UIFont.preferredFont(forTextStyle: .footnote)
        backgroundColor = .badge
        layer.cornerRadius = 8.0
        layer.masksToBounds = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// the section header view for AccountViewController
class TransactionSectionHeaderView: UITableViewHeaderFooterView {
    
    var dayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textColor
        label.text = "This Month"
        return label
    }()
    
    var amountInLabel: BadgeLabel = {
        let label = BadgeLabel()
        label.text = "  in JPY 12000  "
        label.accessibilityValue = "total deposit in month"
        return label
    }()
    
    var amountOutLabel: BadgeLabel = {
        let label = BadgeLabel()
        label.text = "  out JPY -12000  "
        label.accessibilityValue = "total withdraw in month"
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {

        // add background view with overlay color
        let view = UIView()
        view.backgroundColor = .overlay
        backgroundView = view
        
        let stackView = UIStackView(arrangedSubviews: [dayLabel, amountInLabel, amountOutLabel])
        stackView.spacing = 5.0
        stackView.alignment = .center
        stackView.layoutMargins = UIEdgeInsets(top: 1.0, left: 0.0, bottom: 1.0, right: 0.0)
        stackView.isLayoutMarginsRelativeArrangement = true
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
