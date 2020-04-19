//
//  ComicDetailInteractor.swift
//  desafio-ios-anderson-rodrigues
//
//  Created by Anderson Rodrigues on 16/04/2020.
//  Copyright (c) 2020 Anderson Rodrigues. All rights reserved.
//

import UIKit

// MARK: - Protocol
protocol ComicDetailBusinessLogic {
    // MARK: Handle Requests Methods
	func requestComicDetail(request: ComicDetailModel.Comic.Request)
    func requestComicThumbnail(request: ComicDetailModel.CoverImage.Request)
}

protocol ComicDetailDataStore {
	var character: CharacterMarvel { get set }
}

class ComicDetailInteractor: ComicDetailBusinessLogic, ComicDetailDataStore {
	var presenter: ComicDetailPresentationLogic?
	var worker: ComicDetailWorker?
	var character: CharacterMarvel = CharacterMarvel()
	
	// MARK: Request Methods
	
	func requestComicDetail(request: ComicDetailModel.Comic.Request) {
		worker = ComicDetailWorker()
        
        if let worker = worker {
            worker.fetchComicDetail(character: character) { response in
                self.presenter?.presentComicDetail(response: response)
            }
        }
	}
    
    func requestComicThumbnail(request: ComicDetailModel.CoverImage.Request) {
        worker = ComicDetailWorker()
        
        if let worker = worker {
            worker.fetchCoverImage(request: request) { response in
                self.presenter?.presentCoverThumbnail(response: response)
            }
        }
    }
}
