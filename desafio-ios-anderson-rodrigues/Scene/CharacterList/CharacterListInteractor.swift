//
//  CharacterListInteractor.swift
//  desafio-ios-anderson-rodrigues
//
//  Created by Anderson Rodrigues on 15/04/2020.
//  Copyright (c) 2020 Anderson Rodrigues. All rights reserved.
//

import UIKit

// MARK: - Protocol
protocol CharacterListBusinessLogic {
    // MARK: Request Methods
	func requestCharacterList(request: CharacterListModel.Character.Request)
    func requestRefreshCharacterList(request: CharacterListModel.Character.Request)
    func requestCharacterThumbnail(request: CharacterListModel.CoverImage.Request)
    
    // MARK: CRUD operations
    func fetchCharacterRow(request: CharacterListModel.FetchCharacterRowAndConfigureCell.Request)
    
    // MARK: Count
    func count() -> Int
    
    // MARK: Character update lifecycle
    func startCharacterUpdates(request: CharacterListModel.StartCharacterListUpdates.Request)
    func stopCharacterUpdates(request: CharacterListModel.StopCharacterListUpdates.Request)
    
    // MARK: Data Store
    func provideDataStoreToCharacterDetail(request: CharacterListModel.CharacterDetail.Request)
    
    // MARK: Pages
    func requestPageInfo(request: CharacterListModel.CharacterPage.Request)
}

protocol CharacterListDataStore {
	var character: CharacterMarvel { get set }
}

class CharacterListInteractor: CharacterListBusinessLogic, CharacterListDataStore {
	var presenter: CharacterListPresentationLogic?
	var worker: CharacterListWorker?
    var character: CharacterMarvel = CharacterMarvel()
    var characterWorker = CharacterListModel.characterWorker
	
	// MARK: Request Methods
	
	func requestCharacterList(request: CharacterListModel.Character.Request) {
		worker = CharacterListWorker()
		
        if let worker = worker {
            worker.fetchCharacterList(request: request) { response in
                worker.setCurrent(page: request.page.current)
                worker.setOffset(page: response.page.offset)
                worker.setTotal(pages: response.page.total)
                self.presenter?.presentCharacterList(response: response)
            }
        } else {
            let response = CharacterListModel.Character.Response(character: [], page: request.page, error: "There was not possible to finish your request, please try again later")
            presenter?.presentCharacterList(response: response)
        }
	}
    
    func requestRefreshCharacterList(request: CharacterListModel.Character.Request) {
        worker = CharacterListWorker()
        
        if let worker = worker {
            worker.fetchRefreshCharacterList(request: request) { response in
                worker.setCurrent(page: request.page.current)
                worker.setOffset(page: response.page.offset)
                worker.setTotal(pages: response.page.total)
                self.presenter?.presentCharacterList(response: response)
            }
        } else {
            let response = CharacterListModel.Character.Response(character: [], page: request.page, error: "There was not possible to finish your request, please try again later")
            presenter?.presentCharacterList(response: response)
        }
    }
    
    func requestCharacterThumbnail(request: CharacterListModel.CoverImage.Request) {
        worker = CharacterListWorker()
        
        if let worker = worker {
            worker.fetchCoverImage(request: request) { response in
                self.presenter?.presentCharacterThumbnail(response: response)
            }
        } else {
            let response = CharacterListModel.CoverImage.Response(image: nil, cell: request.cell, error: "There was not possible to finish your request, please try again later")
            presenter?.presentCharacterThumbnail(response: response)
        }
    }
    
    // MARK: CRUD operations
    func fetchCharacterRow(request: CharacterListModel.FetchCharacterRowAndConfigureCell.Request) {
        let character = characterWorker.read(at: request.indexPath)
        
        let response = CharacterListModel.FetchCharacterRowAndConfigureCell.Response(character: character, cell: request.cell, indexPath: request.indexPath)
        presenter?.presentFetchedCharacterRowAndConfigureCell(response: response)
    }
    
    // MARK: Count
    
    func count() -> Int {
        return characterWorker.count()
    }
    
    // MARK: Data Store
    
    func provideDataStoreToCharacterDetail(request: CharacterListModel.CharacterDetail.Request) {
        // MARK: TODO
        let character = characterWorker.read(at: request.indexPath)
        self.character = character
        
        let response = CharacterListModel.CharacterDetail.Response()
        presenter?.presentCharacterDetailView(response: response)
    }
    
    // MARK: Pages
    
    func requestPageInfo(request: CharacterListModel.CharacterPage.Request) {
        worker = CharacterListWorker()
        
        if let worker = worker {
            let response = CharacterListModel.CharacterPage.Response(current: worker.getCurrentPage(), offset: worker.getOffsetPage(), total: worker.getTotalPage())
            presenter?.presentPagesInfo(response: response)
        } else {
            let response = CharacterListModel.CharacterPage.Response(current: 1, offset: 0, total: 0)
            presenter?.presentPagesInfo(response: response)
        }
    }
}

// MARK: - NSFetchedResultsController

extension CharacterListInteractor: CharacterCoreDataWorkerDelegate {
    
    // MARK: Character update lifecycle
    func startCharacterUpdates(request: CharacterListModel.StartCharacterListUpdates.Request) {
        characterWorker.delegates.append(self)
    }
    func stopCharacterUpdates(request: CharacterListModel.StopCharacterListUpdates.Request) {
        if let index = characterWorker.delegates.firstIndex(where: { $0 === self }) {
            characterWorker.delegates.remove(at: index)
        }
    }
    
    // MARK: Character row updates
    func characterCoreDataWorker(characterCoreDataWorker: CharacterCoreDataWorker, shouldInsertRowAt indexPath: IndexPath) {
        presenter?.presentInsertRow(at: indexPath)
    }
    func characterCoreDataWorker(characterCoreDataWorker: CharacterCoreDataWorker, shouldDeleteRowAt indexPath: IndexPath) {
        presenter?.presentDeleteRow(at: indexPath)
    }
    func characterCoreDataWorker(characterCoreDataWorker: CharacterCoreDataWorker, shouldUpdateRowAt indexPath: IndexPath, withCharacter character: CharacterMarvel) {
        presenter?.presentUpdatedRow(at: indexPath, withCharacter: character)
    }
    func characterCoreDataWorker(characterCoreDataWorker: CharacterCoreDataWorker, shouldMoveRowFrom from: IndexPath, to: IndexPath, withCharacter character: CharacterMarvel) {
        presenter?.presentMoveRow(from: from, to: to, withCharacter: character)
    }
}
