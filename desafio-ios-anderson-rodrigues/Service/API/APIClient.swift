//
//  APIClient.swift
//  desafio-ios-anderson-rodrigues
//
//  Created by Anderson Rodrigues on 15/04/2020.
//  Copyright © 2020 Anderson Rodrigues. All rights reserved.
//

import Foundation

final class APIClient {
    
    class func getAllCharacters(on page: Int, completion: @escaping(DataContainer<CharacterData>?, Error?) -> Void) {
        APIService.performRequestByDecoder(from: APIRouter.getAllCharacters(page), responseType: SuccessResponse<CharacterData>.self) { response in
            switch response {
            case .success(let value):
                return completion(value.data, nil)
            case .failure(let error):
                return completion(nil, error)
            }
        }
    }
    
    class func getAllComics(by characterID: Int, completion: @escaping([ComicData], Error?) -> Void) {
        APIService.performRequestByDecoder(from: APIRouter.getAllComics(characterID), responseType: SuccessResponse<ComicData>.self) { response in
            switch response {
            case .success(let value):
                return completion(value.data.results, nil)
            case .failure(let error):
                return completion([], error)
            }
        }
    }
    
    class func downloadPosterImage(path: String, size: ImageSize, ext: String, completion: @escaping (Data?, Error?) -> Void) {
        
        APIService.performRequestByData(from: APIRouter.getImageFromURL(path, size, ext)) { response in
            switch response {
            case .success(let value):
                return completion(value, nil)
            case .failure(let error):
                return completion(nil, error)
            }
        }
    }
}
