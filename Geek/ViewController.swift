//
//  ViewController.swift
//  Geek
//
//  Created by Srikanth S on 20/05/22.
//


import UIKit
import Alamofire

class ViewController: UIViewController {
    
    
    enum TableSection: Int {
          case userList
          case loader
      }

 
    // MARK: - Outlet
    @IBOutlet weak var tblv: UITableView!
    @IBOutlet weak var searchBar: SearchBar!
    
    // MARK: - Injection
    let presenter = GeekPresenter(dataService: DataService())
    var geekList:Event?
    private let pageLimit = 20
    private var currentLastId: Int? = 1
    var searchController: UISearchController!
   
    private var users = [Event]() {
          didSet {
              DispatchQueue.main.async { [weak self] in
                  self?.tblv.reloadData()
              }
          }
      }
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        configureSearchController()

        fetchData(withId: "swift")
        
    }
    
    private func setupView() {
        tblv.rowHeight = 150
        tblv.dataSource = self
        tblv.delegate = self
        tblv.separatorStyle = .none
        
       }
    
    func configureSearchController() {
        self.searchBar.delegate = self
        searchBar.clearButtonColor      = .white
        searchBar.cancelButtonColor     = .white
        searchBar.searchIconColor       = .white
        searchBar.placeholderColor      = .white
        searchBar.textColor             = .white
        searchBar.capabilityButtonColor = .blue
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.backgroundColor = .black

    }
    

    // MARK: - Networking
    private func fetchData(withId id: String, completed: ((Bool) -> Void)? = nil ) {
        presenter.fetchmovie(withId: id)
        
        presenter.updateLoadingStatus = {

        }
        
        presenter.showAlertClosure = {
            if let error = self.presenter.error {
                print(error.localizedDescription)
                completed?(false)
            }
        }
        
        presenter.didFinishFetch = {
            if let results = self.presenter.geekList {
                
                    self.users = results.events
            }
            completed?(true)
            
        }
    }
 
}

// MARK: - Tableview DataSource and Delegate -
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let listSection = TableSection(rawValue: section) else { return 0 }
          switch listSection {
          case .userList:
              return users.count
          case .loader:
              return users.count >= pageLimit ? 1 : 0
          }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = TableSection(rawValue: indexPath.section) else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovileListCell", for: indexPath) as! MovileListCell
        
        switch section {
            case .userList:
            let result = users[indexPath.row]
            cell.config(event: result)
            case .loader:
            cell.textLabel?.textColor = .systemBlue
            }
             
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
       
    }
    
    private func hideBottomLoader() {
         DispatchQueue.main.async {
             let lastListIndexPath = IndexPath(row: self.users.count - 1, section: TableSection.userList.rawValue)
             self.tblv.scrollToRow(at: lastListIndexPath, at: .bottom, animated: true)
         }
     }
}


extension ViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        self.searchBar.showsCancelButton = false
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        fetchData(withId: searchBar.text ?? "")
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        self.searchBar.showsCancelButton = true

    }

}
