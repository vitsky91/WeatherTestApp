//
//  SearchViewController.swift
//  WeatherTestApp
//
//  Created by Vitalii Sydorskyi on 1/19/20.
//  Copyright © 2020 Vitalii Sydorskyi. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    private var filteredCities = [CityModel]()
    
    private var isSearchBarEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search city"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchController.searchBar.delegate = self
        searchController.searchBar.showsCancelButton = true
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        
        searchBar.showsCancelButton = false
        dismiss(animated: true, completion: nil)
    }
    
}

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text ?? "")
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        
        filteredCities = DataManager.citiesArray.filter({ (model) -> Bool in
            return (model.city?.lowercased().contains(searchText.lowercased()) ?? false)
        })
        
        tableView.reloadData()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return isFiltering ? filteredCities.count : DataManager.citiesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = isFiltering ? filteredCities[indexPath.row].city : DataManager.citiesArray[indexPath.row].city
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let pickedCity = DataManager.citiesArray.filter({$0.city == cell?.textLabel?.text}).first
        
        if let lon = pickedCity?.lng, let lat = pickedCity?.lat {
            NetworkManger.shared.getWeatherData(lon: Double(lon), lat: Double(lat))
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
}
