//
//  CharacterListModels.swift
//  desafio-ios-anderson-rodrigues
//
//  Created by Anderson Rodrigues on 15/04/2020.
//  Copyright (c) 2020 Anderson Rodrigues. All rights reserved.
//

import UIKit

enum CharacterListModel {
    
    // MARK: - Worker
    static var characterWorker = CharacterCoreDataWorker.shared
    
	// MARK: Model
    struct DisplayedCell {
        var name: String
        var image: Data?
        var url: String?
        var ext: String?
    }
    
    struct DisplayedImage {
        var cover: UIImage
    }
    
    struct Page {
        var current: Int
        var offset: Int
        var total: Int
    }
    
    // MARK: CRUD operations
	enum Character {
		struct Request {
            var page: Page
        }
		struct Response {
            var character: [CharacterMarvel]
            var page: Page
            var error: String?
		}
		struct ViewModel {
            var character: [CharacterMarvel]
            var page: Page
            var error: String?
		}
	}
    
    enum CharacterDetail {
        struct Request {
            var indexPath: IndexPath
        }
        struct Response { }
        struct ViewModel { }
    }
    
    enum CharacterPage {
        struct Request { }
        struct Response {
            var current: Int
            var offset: Int
            var total: Int
        }
        struct ViewModel {
            var current: Int
            var offset: Int
            var total: Int
        }
    }
    
    enum FetchCharacterRowAndConfigureCell {
        struct Request {
            var indexPath: IndexPath
            var cell: CharacterCollectionViewCell?
        }
        struct Response {
            var character: CharacterMarvel
            var cell: CharacterCollectionViewCell?
            var indexPath: IndexPath
        }
        struct ViewModel {
            var displayedCharacter: DisplayedCell
            var cell: CharacterCollectionViewCell?
            var indexPath: IndexPath
        }
    }
    
    enum CoverImage {
        struct Request {
            var url: String
            var size: ImageSize
            var ext: String
            var indexPath: IndexPath
            var cell: CharacterCollectionViewCell
        }
        struct Response {
            var image: Data?
            var cell: CharacterCollectionViewCell
            var error: String?
        }
        struct ViewModel {
            var displayedImage: DisplayedImage?
            var cell: CharacterCollectionViewCell
            var error: String?
        }
    }
    
    // MARK: - Character List update lifecycle
    
    enum StartCharacterListUpdates {
        struct Request { }
        struct Response { }
        struct ViewModel { }
    }
    
    enum StopCharacterListUpdates {
        struct Request { }
        struct Response { }
        struct ViewModel { }
    }
}
