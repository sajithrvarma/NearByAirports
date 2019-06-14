//
//  Airports.swift
//  NearbyAirports
//
//  Created by Sajith Ramavarma on 13/06/19.
//  Copyright © 2019 Sajith Ramavarma. All rights reserved.
//
import CoreLocation

struct AirportWrapper : Codable{
    var airports : [Airport]
}
struct Airport: Codable {
    var name:String?
    var latitude:Double?{
        guard let lat = lat else { return 0 }
       return Double(lat)
    }
    var longitude:Double?{
        guard let long = long else { return 0 }
        return Double(long)
    }
    var lat:String?
    var long:String?
    var city:String?
    var country:String?
    var runwayLength:String?
    var location: CLLocation? {
        return CLLocation(latitude: latitude ?? 0, longitude: longitude ?? 0)
    }
    private enum CodingKeys: String, CodingKey{
      case name = "name"
      case lat = "lat"
      case long = "lon"
      case city = "city"
      case country = "country"
      case runwayLength = "runway_length"
    }
}
