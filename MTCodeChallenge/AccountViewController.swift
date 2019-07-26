//  Copyright © 2019 Sam Xu. All rights reserved.
//

import UIKit

class AccountViewController: UITableViewController {

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
        
        tableView.tableHeaderView = headerView

        // start fetching the account's transaction
        viewModel.fetchAccount()
    }

}
