//
//  AirportTableViewModel.swift
//  NearbyAirports
//
//  Created by Sajith Ramavarma on 13/06/19.
//  Copyright © 2019 Sajith Ramavarma. All rights reserved.
//
import MapKit
struct AirportTableViewModel:Downloadable,Parsable {
    var airportDetails:[Airport]?
    func getSortedList(selectedCity: City, completionHandler : @escaping (([Airport])->()), errorHandler: @escaping ((String)-> ())){
        getAirportList(completionHandler: { (airports) in
            let sortedAirports = airports.sorted(by: { (left, right) -> Bool in
                let leftDistance: Double = selectedCity.location?.distance(from: left.location!) ?? 0
                let rightDistance : Double = selectedCity.location?.distance(from: right.location!) ?? 0
                return leftDistance.isLess(than: rightDistance)
            })
            completionHandler(sortedAirports)

        }) { (errorMessage) in
            errorHandler(errorMessage)
        }
       
    }
    func getAirportList( completionHandler : @escaping (([Airport])->()), errorHandler: @escaping ((String)-> ())){
        guard airportDetails == nil else {
            if let airports = airportDetails{
                completionHandler(airports)
            }
            return
        }
        downloadData(withURLString: Constants.Webservice.airportDetailsUrl) { (result) in
            switch result{
            case .error(message: let msg): 
                errorHandler(msg)
            case .value(let val):
                self.parseJSONData(withData: val, completion: { (parsedResult) in
                    switch parsedResult {
                    case .value(let airports):
                        completionHandler(airports)
                    case .error(let err):
                        errorHandler(err)
                        print("error")
                        
                    }
                })
                
                    
            }
        }
    }
}
