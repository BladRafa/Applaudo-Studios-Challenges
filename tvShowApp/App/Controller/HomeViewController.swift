//
//  HomeViewController.swift
//  tvShowApp
//
//  Created by Walter Bladimir Rafael on 22/2/21.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var viewModel = HomeViewModel()
    
    // Flag to safeguard an one time refresh of screen update
    var isRefreshInProgress = false
    var isLoaded = false
    
    // MARK: LifeCycle App
    override func viewDidLoad() {
        super.viewDidLoad()
        customRender()
        prepareTableView()
        observeEvents()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.rowHeight = tableView.frame.height
        !isLoaded ? refreshScreen() : ()
        guard Utilities.validateSession() else {
            invalidSession()
            return
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Prepare the table view
    private func prepareTableView() {
        tableView.dataSource = self
        PaginationCell.registerWithTable(tableView)
    }
    
    // Function to observe various event call backs from the viewmodel as well as Notifications
    private func observeEvents() {
        viewModel.reloadTable = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.isRefreshInProgress = false
                self?.isLoaded = true
                ActivityIndicator.sharedIndicator.hideActivityIndicator()
            }
        }
        
        viewModel.showSelected = { [weak self] show in
            DispatchQueue.main.async {
                self?.navigateToShowDetailScreenWithShow(show)
            }
        }
    }
    
    @objc private func refreshButtonPressed() {
        guard Utilities.hasInternet() else {
            self.alert(message: Constants.App.NoInternetText, title:Constants.App.msgInfo)
            return
        }
        refreshScreen()
    }
    
    @objc private func filterButtonPresed() {
        guard Utilities.hasInternet() else {
            self.alert(message: Constants.App.NoInternetText, title:Constants.App.msgInfo)
            return
        }
        filterData()
    }
    
    // Refresh the screen when refresh button is pressed
    private func refreshScreen() {
        guard Utilities.hasInternet() else {
            self.alert(message: Constants.App.NoInternetText, title:Constants.App.msgInfo)
            viewModel.refreshScreen()
            return
        }
        isRefreshInProgress = true
        ActivityIndicator.sharedIndicator.displayActivityIndicator(onView: view)
        viewModel.refreshScreen()
    }
    
    // Invalid Session
    private func invalidSession() {
        
        let alert = UIAlertController(title: Constants.App.SesionErrorText,
            message: "",
            preferredStyle: .alert)
        let action = UIAlertAction(title: Constants.App.CerrarTitleBtn2, style: .default, handler: { (action) -> Void in
            AppData.sharedData.resetData()
                       AppData.sharedData.removeToken()
                       let controller = self.storyboard?.instantiateViewController(withIdentifier: Constants.App.login) as! LoginViewController
                       self.pushToViewController(controller: controller, animated: false)
            })
        alert.addAction(action)
        alert.view.tintColor = UIColor.black
        alert.view.backgroundColor = UIColor.white
        alert.view.layer.cornerRadius = 25
        present(alert, animated: true, completion: {})
    }
    
    // Filter data is pressed
    private func filterData() {
        
        let alert = UIAlertController(title: "Filter",
            message: "",
            preferredStyle: .alert)
            ShowType.allShowType().forEach({
            let type = $0
            let action = UIAlertAction(title:  type.displayText(), style: .default, handler: { (action) -> Void in
                            AppData.sharedData.showTypeSelected = type
                               self.refreshScreen()
                })
            alert.addAction(action)

        })
        alert.view.tintColor = UIColor.black
        alert.view.backgroundColor = UIColor.white
        alert.view.layer.cornerRadius = 25
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
        alert.addAction(cancel)
        present(alert, animated: true, completion: {})
    }
    
    // Provides a paging cell
    private func cellForPagingCell(indexPath: IndexPath, viewModel: PaginationCellVM)->PaginationCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PaginationCell.reuseIdentifier, for: indexPath) as! PaginationCell
        cell.selectionStyle = .none
        cell.prepareCell(viewModel: viewModel)
        return cell
    }
    
    // MARK: Customize View
    private func customRender() {
        // Customize Navigation Controller for Home View Controller
        let refreshBtn = UIButton(type: UIButton.ButtonType.custom)
        refreshBtn.setBackgroundImage(UIImage(named: Constants.App.refresh), for: .normal)
        refreshBtn.addTarget(self, action:#selector(refreshButtonPressed), for: .touchUpInside)
        refreshBtn.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
        refreshBtn.layoutIfNeeded()
        refreshBtn.subviews.first?.contentMode = .scaleAspectFit
        let refreshButton = UIBarButtonItem(customView: refreshBtn)
        
        let filterhBtn = UIButton(type: UIButton.ButtonType.custom)
        filterhBtn.setBackgroundImage(UIImage(named: Constants.App.filterImage), for:.normal)
        filterhBtn.addTarget(self, action:#selector(filterButtonPresed), for: .touchUpInside)
        filterhBtn.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
        let filterButton = UIBarButtonItem(customView: filterhBtn)
        filterhBtn.layoutIfNeeded()
        filterhBtn.subviews.first?.contentMode = .scaleAspectFit

        navigationItem.rightBarButtonItems = [filterButton,refreshButton]
        navigationController?.navigationBar.isHidden = false
        navigationItem.setHidesBackButton(true, animated:false)
        navigationController?.navigationBar.renderlogo()
    }
}

// MARK: Routing
extension HomeViewController {
    
    private func navigateToShowDetailScreenWithShow(_ show: Show) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: Constants.App.detail) as! DetailViewController
        controller.show = show
        pushToViewController(controller: controller, animated: true)
   }
}

// MARK: UITableViewDatasource
extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = viewModel.cellType(forIndex: indexPath)
        switch cellType {
        case .pagingCell(let model):
            return cellForPagingCell(indexPath: indexPath, viewModel: model)
        }
    }
}
