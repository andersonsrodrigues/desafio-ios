//
//  CharacterDetailInteractor.swift
//  desafio-ios-anderson-rodrigues
//
//  Created by Anderson Rodrigues on 16/04/2020.
//  Copyright (c) 2020 Anderson Rodrigues. All rights reserved.
//

import UIKit

// MARK: - Protocol
protocol CharacterDetailBusinessLogic {
    // MARK: Request Methods
	func requestCharacteDetail(request: CharacterDetailModel.Character.Request)
    
    // MARK: Data Store
    func provideDataStoreToComicDetail(request: CharacterDetailModel.ComicDetail.Request)
    
}

protocol CharacterDetailDataStore {
	var character: CharacterMarvel { get set }
}

class CharacterDetailInteractor: CharacterDetailBusinessLogic, CharacterDetailDataStore {
	var presenter: CharacterDetailPresentationLogic?
	var worker: CharacterDetailWorker?
	var character: CharacterMarvel = CharacterMarvel()
	
	// MARK: Methods
	
	func requestCharacteDetail(request: CharacterDetailModel.Character.Request) {
		let response = CharacterDetailModel.Character.Response(character: character)
		presenter?.presentCharacterDetail(response: response)
	}
    
    // MARK: Data Store
    
    func provideDataStoreToComicDetail(request: CharacterDetailModel.ComicDetail.Request) {
        let response = CharacterDetailModel.ComicDetail.Response()
        presenter?.presentComicDetailView(response: response)
    }
}
