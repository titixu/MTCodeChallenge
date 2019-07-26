//  Copyright © 2019 Sam Xu. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {
    
    private let accountCellIdentifier = "accountCellIdentifier"
    
    var apiClient: APIClient
    
    var tableHeaderView = AmountHeaderView(frame: CGRect(x: 0, y: 0, width: 150, height: 130))
    
    // delay creating viewModel as self.tableView may not be loaded at that time
    lazy var viewModel: HomeViewModel = {
        HomeViewModel(apiClient: apiClient,
                      onLoading: {
                        DispatchQueue.main.async {
                            // You won't see the refresh loading as it ends too fast
                            self.tableView.refreshControl = UIRefreshControl()
                            self.tableView.refreshControl?.beginRefreshing()
                        }
        },
                      onUpdate: { (viewModel) in
                        // onUpdate is when the view model is updated the data
                        DispatchQueue.main.async {
                            // stop the loading indicator
                            self.tableView.refreshControl?.endRefreshing()
                            self.tableView.refreshControl = nil
                            
                            self.tableView.reloadData()
                            self.tableHeaderView.amountTitle.text = viewModel.totalAmount
                        }
        })
    }()
    
    init(style: UITableView.Style, apiClient: APIClient) {
        self.apiClient = apiClient
        super.init(style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultNavigationBarLayout()
        
        // view setup
        title = "Balances"
        view.backgroundColor = UIColor.appBackground
        
        // tableView setup
        tableView.register(AccountCell.self, forCellReuseIdentifier: accountCellIdentifier)
        tableView.tableHeaderView = tableHeaderView
        
        // insert an empty footer view to remove the empty cells
        tableView.tableFooterView = UIView(frame: .zero)
        
        // insert an empty footer view to remove the empty cells
        tableView.tableFooterView = UIView(frame: .zero)
        
        viewModel.updateAccounts()
    }
    
}

// MARK: - Table view data sourcce
// data should be provided from view model
extension HomeViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleForHeader(inSection: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let account = viewModel.account(indexPath: indexPath)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: accountCellIdentifier, for: indexPath) as? AccountCell else {
            return UITableViewCell()
        }
        
        cell.nicknameLabel.text = account.nickname
        cell.amountLabel.text = viewModel.amountString(account: account)
        
        return cell
    }
    
}

// MARK: - Table View Delegate
extension HomeViewController {
    // customize the section header a bit
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let view = view as? UITableViewHeaderFooterView else { return }
        view.textLabel?.textColor = .textColor
        let overyLay = UIView(frame: .zero)
        overyLay.backgroundColor = .overlay
        view.backgroundView = overyLay
    }
    
    // some space between rows
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let account = viewModel.account(indexPath: indexPath)
        let viewController = AccountViewController(style: .plain, apiClient: apiClient, account: account)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
