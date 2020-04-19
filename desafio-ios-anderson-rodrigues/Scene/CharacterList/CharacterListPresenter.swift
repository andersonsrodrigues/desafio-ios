//
//  CharacterListPresenter.swift
//  desafio-ios-anderson-rodrigues
//
//  Created by Anderson Rodrigues on 15/04/2020.
//  Copyright (c) 2020 Anderson Rodrigues. All rights reserved.
//

import UIKit

// MARK: - Protocol
protocol CharacterListPresentationLogic {
    // MARK: Present Methods
	func presentCharacterList(response: CharacterListModel.Character.Response)
    func presentCharacterThumbnail(response: CharacterListModel.CoverImage.Response)
    func presentCharacterDetailView(response: CharacterListModel.CharacterDetail.Response)
    
    // MARK: CRUD operations
    func presentFetchedCharacterRowAndConfigureCell(response: CharacterListModel.FetchCharacterRowAndConfigureCell.Response)
    
    // MARK: Character row updates
    func presentInsertRow(at indexPath: IndexPath)
    func presentDeleteRow(at indexPath: IndexPath)
    func presentUpdatedRow(at indexPath: IndexPath, withCharacter character: CharacterMarvel)
    func presentMoveRow(from: IndexPath, to: IndexPath, withCharacter character: CharacterMarvel)
    
    // MARK: Pages
    func presentPagesInfo(response: CharacterListModel.CharacterPage.Response)
}

class CharacterListPresenter: CharacterListPresentationLogic {
	weak var viewController: CharacterListDisplayLogic?
	
	// MARK: Present Methods
    
    func presentCharacterList(response: CharacterListModel.Character.Response) {
        let viewModel = CharacterListModel.Character.ViewModel(character: response.character, page: response.page, error: response.error)
        
        if let _ = response.error {
            viewController?.displayErrorCharacterList(viewModel: viewModel)
        } else {
            viewController?.displayCharacterList(viewModel: viewModel)
        }
    }
    
    func presentCharacterThumbnail(response: CharacterListModel.CoverImage.Response) {
        if let _ = response.error {
            let viewModel = CharacterListModel.CoverImage.ViewModel(displayedImage: nil, cell: response.cell, error: response.error)
            viewController?.displayErrorCharacterThumbnail(viewModel: viewModel)
        } else {
            if let data = response.image {
                let displayImage = convert(data: data)
                let viewModel = CharacterListModel.CoverImage.ViewModel(displayedImage: displayImage, cell: response.cell, error: response.error)
                viewController?.displayCharacterThumbnail(viewModel: viewModel)
            } else {
                let viewModel = CharacterListModel.CoverImage.ViewModel(displayedImage: nil, cell: response.cell, error: "We could not find any information from your request")
                viewController?.displayErrorCharacterThumbnail(viewModel: viewModel)
            }
        }
    }
    
    func presentCharacterDetailView(response: CharacterListModel.CharacterDetail.Response) {
        let viewModel = CharacterListModel.CharacterDetail.ViewModel()
        
        viewController?.displayCharacterDetailsView(viewModel: viewModel)
    }
    
    // MARK: CRUD operation
    
    func presentFetchedCharacterRowAndConfigureCell(response: CharacterListModel.FetchCharacterRowAndConfigureCell.Response) {
        let displayCharacterCell = formatCell(character: response.character)
        
        let viewModel = CharacterListModel.FetchCharacterRowAndConfigureCell.ViewModel(displayedCharacter: displayCharacterCell, cell: response.cell, indexPath: response.indexPath)
        viewController?.displayFetchedCharacterRowAndConfigureCell(viewModel: viewModel)
    }
    
    // MARK: Pages
    
    func presentPagesInfo(response: CharacterListModel.CharacterPage.Response) {
        let viewModel = CharacterListModel.CharacterPage.ViewModel(current: response.current, offset: response.offset, total: response.total)
        viewController?.displayPageInfo(viewModel: viewModel)
    }
    
    // MARK: - Format Character Cell
    
    private func formatCell(character: CharacterMarvel) -> CharacterListModel.DisplayedCell {
        return CharacterListModel.DisplayedCell(name: character.name!, image: character.thumbnail, url: character.thumbnailURL, ext: character.thumbnailExt)
    }
	
	// MARK: - Format data to displayed entry
    
    private func convert(data: Data) -> CharacterListModel.DisplayedImage? {
        if let image = UIImage(data: data) {
            return CharacterListModel.DisplayedImage(cover: image)
        } else {
            return nil
        }
    }
}

// MARK: - NSFetchedResultsController

extension CharacterListPresenter {
    // MARK: Character row updates
    
    func presentInsertRow(at indexPath: IndexPath) {
        viewController?.displayInsertedRow(at: indexPath)
    }
    
    func presentDeleteRow(at indexPath: IndexPath) {
        viewController?.displayDeletedRow(at: indexPath)
    }
    
    func presentUpdatedRow(at indexPath: IndexPath, withCharacter character: CharacterMarvel) {
        let displayedCharacter = formatCell(character: character)
        viewController?.displayUpdatedRow(at: indexPath, withDisplayedCharacter: displayedCharacter)
    }
    
    func presentMoveRow(from: IndexPath, to: IndexPath, withCharacter character: CharacterMarvel) {
        let displayedCharacter = formatCell(character: character)
        viewController?.displayMovedRow(from: from, to: to, withDisplayedCharacter: displayedCharacter)
    }
}
