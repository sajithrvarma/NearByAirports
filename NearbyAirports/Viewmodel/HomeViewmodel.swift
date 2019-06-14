//
//  HomeViewmodel.swift
//  NearbyAirports
//
//  Created by Sajith Ramavarma on 13/06/19.
//  Copyright © 2019 Sajith Ramavarma. All rights reserved.
//

import MapKit

struct HomeViewmodel {
 var items:[CityWrapper]? = [CityWrapper]()

    mutating func fetchData(completionHandler:@escaping ((([Airport])->())), errorHandler:@escaping ((String)->())){
        self.items = getCityList()
        let airportViewModel = AirportTableViewModel()
        airportViewModel.getAirportList(completionHandler: { (airports) in
            completionHandler(airports)
        }) { (errorMessage) in
            errorHandler(errorMessage)
        }
       
    }
    mutating func updateSearchResultsForSearchController(searchController: UISearchController, completionHandler:@escaping (([CityWrapper]?) ->())) {
        guard let _ = searchController.searchBar.text else { return }
        self.items = getCityList()
        if let searchText = searchController.searchBar.text{
            let cities = getCityForName(name: searchText)
            completionHandler(cities)
        }
        
    }
    func getCityList() -> [CityWrapper]? {
        if items != nil && items!.count > 0{
            return items!
        }else{
            if let cityList = City.loadJson(filename: "populatedPlaces"){
                //self.matchingItems = cityList
                return cityList
            }
            return nil
        }
    }
    func getCityForName(name: String) -> [CityWrapper]?{
        let selected :[CityWrapper] = items!.filter({$0.city.name?.contains(name) ?? false}
        )
        return selected
    }
}
