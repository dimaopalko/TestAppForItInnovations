//
//  MainViewController.swift
//  TestAppForItInnovations
//
//  Created by Dima Opalko on 08.01.2020.
//  Copyright © 2020 Dima Opalko. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController, PersonCellDelegate {
    
    

    private let networkService = NetworkService()
    private var personsList = [Person]()
    private let searchController = UISearchController(searchResultsController: nil)
    private var linkToDownloadPDF = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupSearchBar()
    }
    
    func setupSearchBar() {
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.searchTextField.keyboardType = .default
        navigationItem.searchController = searchController
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
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
        cell.placeOfWorkLabel.text = personsList[indexPath.row].plaseOfWork ?? "No Place Of Work"
        cell.positionLabel.text = personsList[indexPath.row].position ?? "No Position"
        if personsList[indexPath.row].linkPDF == nil {
            cell.PDFButtonOutlet.isHidden = true
        } else {
            cell.PDFButtonOutlet.isHidden = false
        }
        cell.tag = indexPath.row
        cell.PDFDelegate = self
        return cell
    }
    
    func PDFButtonClickAtIndex(index: Int) {
        linkToDownloadPDF = personsList[index].linkPDF!
        performSegue(withIdentifier: "ToPDFViewController", sender: self)
    }
    
    // MARK: - Table View delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToPDFViewController" {
            if let PDFViewController = segue.destination as? PDFViewController {
                PDFViewController.linkToDownload = linkToDownloadPDF
            }
        }
    }
}

// MARK: - Search Bar delegate

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
