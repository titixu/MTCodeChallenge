
//  Copyright © 2019 Sam Xu. All rights reserved.
//

import UIKit

// table header view on showing amount of title balances
class AmountHeaderView: UIView {
    
    let titleLable: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .textColor
        label.text = "Digital Money"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    let amountTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .textColor
        label.text = "$$$$"
        label.contentHuggingPriority(for: .horizontal)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.backgroundColor = .appBackground
        let stackView = UIStackView(arrangedSubviews: [titleLable, amountTitle])
        stackView.axis = .vertical
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: .padding),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .padding),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.padding),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.padding)
            ])
    }
    
}


class AccountCell: UITableViewCell {
    
    var nicknameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textColor
        // compree when the nick name is too long
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    var amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textColor
        label.textAlignment = .right
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
        let stackView = UIStackView(arrangedSubviews: [nicknameLabel, amountLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8.0
        
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .padding),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.padding)
            ])
    }
}
