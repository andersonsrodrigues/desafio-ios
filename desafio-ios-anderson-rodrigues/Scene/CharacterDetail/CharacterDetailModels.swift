//
//  CharacterDetailModels.swift
//  desafio-ios-anderson-rodrigues
//
//  Created by Anderson Rodrigues on 16/04/2020.
//  Copyright (c) 2020 Anderson Rodrigues. All rights reserved.
//

import UIKit

enum CharacterDetailModel {
	
    
    // MARK: CRUD operations
    enum Character {
        struct Request { }
        struct Response {
            var character: CharacterMarvel
        }
        struct ViewModel {
            var character: CharacterMarvel
        }
    }
    
    enum ComicDetail {
        struct Request { }
        struct Response { }
        struct ViewModel { }
    }
}
