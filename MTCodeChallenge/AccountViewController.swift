//  Copyright © 2019 Sam Xu. All rights reserved.
//

import UIKit

class AccountViewController: UITableViewController {

    private let transactionCellIdentifier = "transactionCellIdentifier"
    
    var apiClient: APIClient
    private let account: Account
    
    lazy var headerView = AccountHeaderView(isForeignAccountType: self.account.type == .foreign,
                                            frame: CGRect(x: 0, y: 0, width: 150, height: 130))
    
    // delay creating viewModel, wait for the view to be loaded first
    lazy var viewModel: AccountViewModel = {
        AccountViewModel(accountID: account.id,
                         apiClient: apiClient,
                         onLoading: { (viewModel) in
                            DispatchQueue.main.async {
                                // this won't be notice as it end too fast
                                // but will get display if it is a long loading process
                                self.tableView.refreshControl = UIRefreshControl()
                                self.tableView.refreshControl?.beginRefreshing()
                            }
        },
                         onComplete: { (viewModel) in
                            DispatchQueue.main.async {
                                // end the refesh loading indicator
                                self.tableView.refreshControl?.endRefreshing()
                                self.tableView.refreshControl = nil
                                self.tableView.reloadData()
                            }
        })
    }()
    
    init(style: UITableView.Style, apiClient: APIClient, account: Account) {
        self.apiClient = apiClient
        self.account = account
        
        super.init(style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultNavigationBarLayout()
        
        self.title = account.nickname
        view.backgroundColor = UIColor.appBackground
        
        tableView.register(TransactionCell.self, forCellReuseIdentifier: transactionCellIdentifier)
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = UIView()
        
        // start fetching the account's transaction
        viewModel.fetchAccount()
    }

}

// Table View data source
extension AccountViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let transaction = viewModel.transaction(indexPath: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: transactionCellIdentifier, for: indexPath) as? TransactionCell  else {
            return UITableViewCell()
        }
        
        cell.dayLabel.text = viewModel.transactionDayString(transaction)
        cell.descirptionLabel.text = transaction.description
        cell.amountLabel.text = transaction.amount.currency
        return cell
    }
}

// TableView Delegate
extension AccountViewController {
    // some space between rows
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
}
