//
//  Result.swift
//
//  Created by Sajith Ramavarma on 13/06/19.
//  Copyright © 2019 Sajith Ramavarma. All rights reserved.
//
//


typealias ResultBlock<T> = (Result<T>) -> ()

enum Result<T> {
    case value(T)
    case error(_: String)
}
