//
//  ComicDetailModels.swift
//  desafio-ios-anderson-rodrigues
//
//  Created by Anderson Rodrigues on 16/04/2020.
//  Copyright (c) 2020 Anderson Rodrigues. All rights reserved.
//

import UIKit

enum ComicDetailModel {
    
    // MARK: - Worker
    static var comicWorker = ComicCoreDataWorker.shared
    
	// MARK: Model
    struct DisplayedImage {
        var cover: UIImage
    }
	
    // MARK: CRUD operations
	enum Comic {
		struct Request { }
		struct Response {
            var comic: ComicMarvel?
            var error: String?
		}
		struct ViewModel {
            var comic: ComicMarvel?
            var error: String?
		}
	}
    
    enum CoverImage {
        struct Request {
            var url: String
            var size: ImageSize
            var ext: String
        }
        struct Response {
            var image: Data?
            var error: String?
        }
        struct ViewModel {
            var displayedImage: DisplayedImage?
            var error: String?
        }
    }
}
