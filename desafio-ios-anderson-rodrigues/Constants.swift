//
//  Constants.swift
//  desafio-ios-anderson-rodrigues
//
//  Created by Anderson Rodrigues on 15/04/2020.
//  Copyright © 2020 Anderson Rodrigues. All rights reserved.
//

import Foundation

/// Enum Method to define types that can be used to make a request
enum Method: String {
    case get = "GET"
    case post = "POST"
}

enum ImageSize: String {
    case portraitSmall = "portrait_small"
    case portraitMedium = "portrait_medium"
    case portraitXLarge = "portrait_xlarge"
    case portraitFantastic = "portrait_fantastic"
    case portraitUncanny = "portrait_uncanny"
    case portraitIncredible = "portrait_incredible"
    case standardSmall = "standard_small"
    case standardMedium = "standard_medium"
    case standardLarge = "standard_large"
    case standardXLarge = "standard_xlarge"
    case standardFantastic = "standard_fantastic"
    case standardAmazing = "standard_amazing"
    case landscapeSmall = "landscape_small"
    case landscapeMedium = "landscape_medium"
    case landscapeLarge = "landscape_large"
    case landscapeXLarge = "landscape_xlarge"
    case landscapeAmazing = "landscape_amazing"
    case landscapeIncredible = "landscape_incredible"
}

/// Enum Endpoint defines all URL requests that the app can use to send
struct Constant {
    struct Server {
        static let baseURL = "https://gateway.marvel.com/v1/public/"
        static let authorizeURL = "?ts=1&apikey=\(Constant.ClientKey.publicKey)&hash=" + "1\(Constant.ClientKey.privateKey)\(Constant.ClientKey.publicKey)".md5
    }
    
    struct ClientKey {
        static let publicKey = "fa3b948c912647967dcfa257186c2c00"
        static let privateKey = "afb8cf1beafe4899c9f4a4055643bb379ab316db"
    }
    
    struct Page {
        static let count = 20
    }
}

enum HTTPHeaderField: String {
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}

struct ImageEntry {
    var cover: Data
}
