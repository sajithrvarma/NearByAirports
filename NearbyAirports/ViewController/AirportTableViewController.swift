//
//  AirportTableViewController.swift
//  NearbyAirports
//
//  Created by Sajith Ramavarma on 13/06/19.
//  Copyright © 2019 Sajith Ramavarma. All rights reserved.
//

import UIKit

class AirportTableViewController: UITableViewController {
    var viewModel: AirportTableViewModel?
    var selectedCity: CityWrapper?
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    func fetchData() {
        if let selectedCity = selectedCity?.city{
            viewModel?.getSortedList(selectedCity: selectedCity, completionHandler: { (airports) in
                self.viewModel?.airportDetails = airports
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }, errorHandler: { (errorMessage) in
                DispatchQueue.main.async {
                    self.alert(message: errorMessage)
                    self.tableView.reloadData()
                }
            })
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let rows = (self.viewModel?.airportDetails?.count ?? 0 < Constants.limit.maximumNumberOfNearByAirports ? self.viewModel?.airportDetails?.count : Constants.limit.maximumNumberOfNearByAirports) ?? 0
        return  rows
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AirportTableViewCell = tableView.dequeueReusableCell(withIdentifier: "airportCell", for: indexPath) as! AirportTableViewCell

        // Configure the cell...
        if let airport = self.viewModel?.airportDetails?[indexPath.row]{
            cell.configure(airport:airport )
        }
        
        return cell
    }
 


}
