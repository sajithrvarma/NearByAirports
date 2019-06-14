//
//  HomeTableViewController.swift
//  NearbyAirports
//
//  Created by Sajith Ramavarma on 13/06/19.
//  Copyright © 2019 Sajith Ramavarma. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    var viewModel = HomeViewmodel()
    var matchingItems:[CityWrapper]? = [CityWrapper]()
    var selectedItem:CityWrapper?
    var airportDetailsHome:[Airport]?
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        setupSearch()
    }
    override func viewWillAppear(_ animated: Bool) {
        searchController.searchBar.isHidden = false
        search()
    }
    override func viewWillDisappear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.searchController.searchBar.isHidden = true
            self.searchController.searchBar.resignFirstResponder()
        }
    }
    func fetchData()  {
        self.showLoading()
        viewModel.fetchData(completionHandler: { (airports) in
            DispatchQueue.main.async {
                self.dismiss(animated: false, completion: nil)
            }
            self.airportDetailsHome = airports
        }) { (errorMessage) in
            DispatchQueue.main.async {
                self.dismiss(animated: false, completion: nil)
            }
            self.alert(message: errorMessage, title: "Couldn't fetch data")
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        let count = matchingItems?.count ?? 0
        return count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResult", for: indexPath)

        // Configure the cell...
        guard  matchingItems != nil else{
            return cell
        }
        if let city = self.matchingItems?[indexPath.row].city{
            cell.textLabel?.text = city.name
            cell.detailTextLabel?.text = city.country
        }
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if let selected = self.matchingItems?[indexPath.row]{
        selectedItem = selected
        performSegue(withIdentifier: "showAirports", sender: selectedItem)
        }
    }
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let airportViewController =  segue.destination as? AirportTableViewController{
            airportViewController.viewModel = AirportTableViewModel()
            airportViewController.viewModel?.airportDetails = airportDetailsHome
            airportViewController.selectedCity = sender as? CityWrapper
        }
        
    }

}
// MARK:-Search
extension HomeTableViewController:UISearchResultsUpdating,UISearchBarDelegate{
    
    func updateSearchResults(for searchController: UISearchController) {
        search()
    }
    func setupSearch() {
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        tableView.tableHeaderView = searchController.searchBar
    }
    func search(){
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            viewModel.updateSearchResultsForSearchController(searchController: searchController) { (results) in
                if let results = results{
                    self.matchingItems = results
                }else{
                   self.matchingItems = nil
                }
                 self.tableView.reloadData()
            }
        }else{
            self.matchingItems = nil
            tableView.reloadData()
        }
    }
}





