//
//  APIProtocol.swift
//  desafio-ios-anderson-rodrigues
//
//  Created by Anderson Rodrigues on 15/04/2020.
//  Copyright © 2020 Anderson Rodrigues. All rights reserved.
//

import Foundation

typealias Parameters = [String: Any]

protocol APIConfiguration  {
    var method: Method { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var base: String { get }
    
    func asURLRequest() throws -> URLRequest
}
