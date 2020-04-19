//
//  CharacterListWorker.swift
//  desafio-ios-anderson-rodrigues
//
//  Created by Anderson Rodrigues on 15/04/2020.
//  Copyright (c) 2020 Anderson Rodrigues. All rights reserved.
//

import UIKit

class CharacterListWorker {
    
    var userDefaults = UserDefaults.standard
    
    func fetchCharacterList(request: CharacterListModel.Character.Request, completion: @escaping(CharacterListModel.Character.Response) -> Void) {
        let characterWorker = CharacterListModel.characterWorker
        characterWorker.setupFetchedResultsController(offset: request.page.offset)
        
        if characterWorker.count() > 0 {
            let data = characterWorker.list()
            let page = CharacterListModel.Page(current: request.page.current, offset: request.page.offset, total: getTotalPage())
            let response = CharacterListModel.Character.Response(character: data, page: page, error: nil)
            completion(response)
        } else {
            APIClient.getAllCharacters(on: request.page.offset) { (data, error) in
                guard let data = data else {
                    let page = CharacterListModel.Page(current: self.getCurrentPage(), offset: self.getOffsetPage(), total: self.getTotalPage())
                    let response = CharacterListModel.Character.Response(character: [], page: page, error: error!.localizedDescription)
                    completion(response)
                    
                    return
                }
                
                for character in data.results {
                    characterWorker.create(obj: character)
                }
                
                let page = CharacterListModel.Page(current: request.page.current, offset: data.offset, total: data.total)
                let response = CharacterListModel.Character.Response(character: characterWorker.list(), page: page, error: nil)
                completion(response)
            }
        }
	}
    
    func fetchRefreshCharacterList(request: CharacterListModel.Character.Request, completion: @escaping(CharacterListModel.Character.Response) -> Void) {
        let characterWorker = CharacterListModel.characterWorker
        
        APIClient.getAllCharacters(on: request.page.offset) { (data, error) in
            guard let data = data else {
                let page = CharacterListModel.Page(current: self.getCurrentPage(), offset: self.getOffsetPage(), total: self.getTotalPage())
                let response = CharacterListModel.Character.Response(character: [], page: page, error: error!.localizedDescription)
                completion(response)
                
                return
            }
            
            characterWorker.erase()
            
            for character in data.results {
                characterWorker.create(obj: character)
            }
            
            let page = CharacterListModel.Page(current: request.page.current, offset: data.offset, total: data.total)
            let response = CharacterListModel.Character.Response(character: characterWorker.list(), page: page, error: nil)
            completion(response)
        }
    }
    
    func fetchCoverImage(request: CharacterListModel.CoverImage.Request, completion: @escaping(CharacterListModel.CoverImage.Response) -> Void) {
        
        let characterWorker = CharacterListModel.characterWorker
        let character = characterWorker.read(at: request.indexPath)
        
        if let image = character.thumbnail {
            let response = CharacterListModel.CoverImage.Response(image: image, cell: request.cell)
            completion(response)
        } else if let url = character.thumbnailURL {
            APIClient.downloadPosterImage(path: url, size: request.size, ext: request.ext) { (data, error) in
                
                guard let data = data else {
                    let response = CharacterListModel.CoverImage.Response(image: nil, cell: request.cell, error: error!.localizedDescription)
                    completion(response)
                
                    return
                }
                
                character.setValue(data, forKey: "thumbnail")
                characterWorker.update(obj: character)
                    
                let response = CharacterListModel.CoverImage.Response(image: data, cell: request.cell)
                completion(response)
            }
        }
    }

    func setCurrent(page: Int) {
        userDefaults.set(page, forKey: "currentPage")
    }
    
    func setOffset(page: Int) {
        userDefaults.set(page, forKey: "offsetPage")
    }
    
    func setTotal(pages: Int) {
        userDefaults.set(pages, forKey: "totalPage")
    }
    
    func getCurrentPage() -> Int {
        return userDefaults.integer(forKey: "currentPage")
    }
    
    func getOffsetPage() -> Int {
        return userDefaults.integer(forKey: "offsetPage")
    }
    
    func getTotalPage() -> Int {
        return userDefaults.integer(forKey: "totalPage")
    }
}
