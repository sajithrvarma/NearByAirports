//
//  Parsable.swift
//
//  Created by Sajith Ramavarma on 13/06/19.
//  Copyright © 2019 Sajith Ramavarma. All rights reserved.
//

import Foundation

protocol Parsable { }

extension Parsable {
  
  func parseJSONData(withData data: Data, completion: ResultBlock<[Airport]>) {
    
    do {
      
      let jsonDecoder = JSONDecoder()
      let forecast = try jsonDecoder.decode([Airport].self, from: data)
      
      completion(Result.value(forecast))
      
    }
    catch {
      print("error", error)
      completion(Result.error(error.localizedDescription))
    }
  }
  
}
