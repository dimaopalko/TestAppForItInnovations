//
//  MainViewController.swift
//  TestAppForItInnovations
//
//  Created by Dima Opalko on 08.01.2020.
//  Copyright © 2020 Dima Opalko. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

    private let networkService = NetworkService()
    private var personsList = [Person]()
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
//        definesPresentationContext = true
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personsList.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PersonTableViewCell
        cell.fullNameLabel?.text = personsList[indexPath.row].firstName! + " " + personsList[indexPath.row].lastName!
        cell.placeOfWorkLabel.text = personsList[indexPath.row].plaseOfWork ?? ""
        cell.positionLabel.text = personsList[indexPath.row].position ?? "No Position"
        if personsList[indexPath.row].linkPDF == nil {
            cell.PDFButtonOutlet.isHidden = true
        } else {
            cell.PDFButtonOutlet.isHidden = false
        }
        
        return cell
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        networkService.fetchPersons(searchText: searchText) { [weak self] (SearchResponce) in
            if SearchResponce != nil {
                self?.personsList = SearchResponce?.persons ?? []
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            } else {
                self?.personsList = []
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
}
