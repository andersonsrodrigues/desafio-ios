//
//  APIRouter.swift
//  desafio-ios-anderson-rodrigues
//
//  Created by Anderson Rodrigues on 15/04/2020.
//  Copyright © 2020 Anderson Rodrigues. All rights reserved.
//

import Foundation

enum APIRouter: APIConfiguration {
    
    case getAllCharacters(Int)
    case getAllComics(Int)
    case getImageFromURL(String, ImageSize, String)
    
    // MARK: - HTTP Method
    internal var method: Method {
        switch self {
        case .getAllCharacters, .getAllComics, .getImageFromURL:
            return .get
        }
    }
    
    // MARK: - Path
    internal var path: String {
        switch self {
        case .getAllCharacters(let value):
            return "characters\(Constant.Server.authorizeURL)&limit=20&offset=\(value)"
        case .getAllComics(let value):
            return "characters/\(value)/comics\(Constant.Server.authorizeURL)"
        case .getImageFromURL(_, let size, let ext):
            return "/\(size.rawValue).\(ext)"
        }
    }
    
    // MARK: - Parameters
    internal var parameters: Parameters? {
        switch self {
        case .getAllCharacters, .getAllComics, .getImageFromURL:
            return nil
        }
    }
    
    // MARK: - URL
    internal var base: String {
        switch self {
        case .getImageFromURL(let value, _, _):
            return value
        case .getAllCharacters, .getAllComics:
            return Constant.Server.baseURL
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = base + path
        
        var urlRequest = URLRequest(url: try url.asURL())
        
        /// HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        /// Parameters
        if let parameters = parameters {
            urlRequest.httpBody = parameters.httpCompatible.data(using: .utf8)
        }
        
        /// Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        return urlRequest
    }
}

extension Dictionary where Key == String {
    
    var httpCompatible: String {
        return String(
            self.reduce("") { "\($0)&\($1.key)=\($1.value)" }
                .replacingOccurrences(of: " ", with: "+")
                .dropFirst()
        )
    }
}

extension String {
    func asURL() throws -> URL {
        guard let url = URL(string: self) else {
            throw fatalError("Error to parse string to URL")
        }
        
        return url
    }
}
