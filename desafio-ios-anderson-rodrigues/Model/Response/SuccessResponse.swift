//
//  SuccessResponse.swift
//  desafio-ios-anderson-rodrigues
//
//  Created by Anderson Rodrigues on 15/04/2020.
//  Copyright © 2020 Anderson Rodrigues. All rights reserved.
//

import Foundation

struct SuccessResponse<T: Decodable>: Decodable {
    var code: Int
    var status: String
    var data: DataContainer<T>
    
    enum CodingKeys: String, CodingKey {
        case code, status, data
    }
}
