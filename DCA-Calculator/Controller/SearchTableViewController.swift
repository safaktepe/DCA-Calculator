//
//  SearchTableViewController.swift
//  DCA-Calculator
//
//  Created by Mert Şafaktepe on 4.09.2022.
//

import UIKit
import Combine

class SearchTableViewController: UITableViewController {

    private let  apiService = APIService()
    private var  subscriber = Set<AnyCancellable>()
    
    private lazy var searchController: UISearchController = {
        let sc                                  = UISearchController(searchResultsController: nil)
        sc.searchResultsUpdater                 = self
        sc.delegate                             = self
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchBar.placeholder                = "Enter a company name or symbol"
        sc.searchBar.autocapitalizationType     = .allCharacters
        return sc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        performSearch()
    }

    //MARK: - Functions
    
    private func setupNavigationBar() {
        navigationItem.searchController         = searchController
    }
    
    private func performSearch() {
        apiService.fetchSymbolsPublisher(keywords: "S&P500").sink { completion in
            switch completion {
            case .failure(let error):
                print(error)
            case .finished: break
            }
        } receiveValue: { searchResults in
            print(searchResults)
        }.store(in: &subscriber)

    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let    cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        return cell
    }
}


extension SearchTableViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    
}
