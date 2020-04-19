//
//  ErrorResponse.swift
//  desafio-ios-anderson-rodrigues
//
//  Created by Anderson Rodrigues on 15/04/2020.
//  Copyright © 2020 Anderson Rodrigues. All rights reserved.
//

import Foundation

struct ErrorResponse: Decodable {
    var code: Int
    var status: String
}

extension ErrorResponse: CustomNSError {
    var errorCode: Int {
        return code
    }
}

extension ErrorResponse: LocalizedError {
    public var errorDescription: String? {
        switch code {
        case 400:
            return StatusMessage.badRequest.rawValue
        case 401:
            return StatusMessage.unauthorized.rawValue
        case 403:
            return StatusMessage.forbidden.rawValue
        case 404:
            return StatusMessage.notFound.rawValue
        case 405:
            return StatusMessage.methodNotAllowed.rawValue
        case 409:
            return StatusMessage.missingData.rawValue
        case 429:
            return StatusMessage.tooManyRequest.rawValue
        case 500:
            return StatusMessage.internalServerError.rawValue
        case 502:
            return StatusMessage.badGateway.rawValue
        case 503:
            return StatusMessage.serviceUnavailable.rawValue
        default:
            return StatusMessage.undefined.rawValue
        }
    }
}

enum StatusMessage: String {
    case badRequest = "There is something undestood, please try again";
    case unauthorized = "The session has been expired";
    case forbidden = "The content your are trying to see is not available";
    case notFound = "The requested resource could not be found";
    case methodNotAllowed = "The current requested is not allowed"
    case missingData = "There is some data missed on your request"
    case tooManyRequest = "The server received too many requests";
    case internalServerError = "The server is experience some issues, please try again later";
    case badGateway = "The server proxy received an invalid response";
    case serviceUnavailable = "All services are currently unavailable, please try again later";
    case undefined = "The server is unavailable, please try again later "
}
