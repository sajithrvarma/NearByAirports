//
//  City.swift
//  NearbyAirports
//
//  Created by Sajith Ramavarma on 13/06/19.
//  Copyright © 2019 Sajith Ramavarma. All rights reserved.
//

import CoreLocation

struct ResponseData: Codable {
    var cities: [CityWrapper]
    private enum CodingKeys: String,CodingKey{
        case  cities = "features"
    }
}
struct CityWrapper: Codable {
    var city: City
    private enum CodingKeys: String,CodingKey{
        case  city = "properties"
    }
}
struct City : Codable {
    var name: String?
    var isoCountryCode :String?
    var country: String?
    var latitude : Double?
    var longitude: Double?
    var location: CLLocation? {
        return CLLocation(latitude: latitude ?? 0, longitude: longitude ?? 0)
    }
    private enum CodingKeys: String, CodingKey {
        case name = "NAME"
        case isoCountryCode = "SOV_A3"
        case country = "SOV0NAME"
        case latitude = "LATITUDE"
        case longitude = "LONGITUDE"
    }
    static func loadJson(filename fileName: String) -> [CityWrapper]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ResponseData.self, from: data)
                return jsonData.cities
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
    

