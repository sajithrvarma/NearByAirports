//
//  Downloadable.swift
//
//  Created by Sajith Ramavarma on 13/06/19.
//  Copyright © 2019 Sajith Ramavarma. All rights reserved.
//

import Foundation

protocol Downloadable { }

extension Downloadable {
  
  func downloadData(withURLString urlString: String, completion: @escaping ResultBlock<Data>) {
    
    guard let proceduresURL = URL(string: urlString) else {
      
      completion(Result.error("Invalid URL"))
      return
    }
    
    let request = URLRequest(url: proceduresURL)
    let session = URLSession.shared
    
    let task = session.dataTask(with: request) { data, URLResponse, error in
      
      guard let data = data else {
        return completion(Result.error("Unable to download data"))
      }
      
      return completion(Result.value(data))
    }
    task.resume()
  }
  
}

