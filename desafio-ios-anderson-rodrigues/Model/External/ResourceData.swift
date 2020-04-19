//
//  ResourceData.swift
//  desafio-ios-anderson-rodrigues
//
//  Created by Anderson Rodrigues on 15/04/2020.
//  Copyright © 2020 Anderson Rodrigues. All rights reserved.
//

import Foundation

struct ResourceData: Decodable {
    var available: Int?
    var returned: Int?
    var collectionURI: String?
    var items: [SummaryEntityData]?
}

struct SummaryEntityData: Decodable {
    var name: String?
    var type: String?
    var resourceURI: String?
}
