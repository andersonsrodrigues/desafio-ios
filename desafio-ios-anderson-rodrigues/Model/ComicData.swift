//
//  ComicData.swift
//  desafio-ios-anderson-rodrigues
//
//  Created by Anderson Rodrigues on 15/04/2020.
//  Copyright © 2020 Anderson Rodrigues. All rights reserved.
//

import Foundation

struct ComicData: Decodable {
    var id: Int?
    var title: String?
    var description: String?
    var prices: [PriceData]
    var thumbnail: ImageData?
    
    func highestPrice() -> Double {
        let high = prices.max { $0.price < $1.price }

        if let price = high?.price {
            return price
        }
        
        return 0.00
    }
}

struct PriceData: Decodable {
    var type: String?
    var price: Double
}

extension ComicData: Comparable {
    static func < (lhs: ComicData, rhs: ComicData) -> Bool {
        return lhs.highestPrice() < rhs.highestPrice() && lhs.title?.caseInsensitiveCompare(rhs.title!) == .orderedAscending
    }

    static func == (lhs: ComicData, rhs: ComicData) -> Bool {
        return lhs.highestPrice() == rhs.highestPrice() && lhs.title?.caseInsensitiveCompare(rhs.title!) == .orderedSame
    }

    static func > (lhs: ComicData, rhs: ComicData) -> Bool {
        return lhs.highestPrice() > rhs.highestPrice() && lhs.title?.caseInsensitiveCompare(rhs.title!) == .orderedDescending
    }
}
