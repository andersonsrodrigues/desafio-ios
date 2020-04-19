//
//  DataContainer.swift
//  desafio-ios-anderson-rodrigues
//
//  Created by Anderson Rodrigues on 15/04/2020.
//  Copyright © 2020 Anderson Rodrigues. All rights reserved.
//

import Foundation

struct DataContainer<T: Decodable>: Decodable {
    var offset: Int
    var limit: Int
    var total: Int
    var count: Int
    var results: [T]
}
