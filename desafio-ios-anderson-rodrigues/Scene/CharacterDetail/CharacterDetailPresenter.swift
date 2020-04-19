//
//  CharacterDetailPresenter.swift
//  desafio-ios-anderson-rodrigues
//
//  Created by Anderson Rodrigues on 16/04/2020.
//  Copyright (c) 2020 Anderson Rodrigues. All rights reserved.
//

import UIKit

// MARK: - Protocol
protocol CharacterDetailPresentationLogic {
    //MARK: Present Character Methods
	func presentCharacterDetail(response: CharacterDetailModel.Character.Response)
    func presentComicDetailView(response: CharacterDetailModel.ComicDetail.Response)
}

class CharacterDetailPresenter: CharacterDetailPresentationLogic {
	weak var viewController: CharacterDetailDisplayLogic?
	
	// MARK: Present Character
	
	func presentCharacterDetail(response: CharacterDetailModel.Character.Response) {
        let viewModel = CharacterDetailModel.Character.ViewModel(character: response.character)
		viewController?.displayCharacterDetail(viewModel: viewModel)
	}
    
    func presentComicDetailView(response: CharacterDetailModel.ComicDetail.Response) {
        let viewModel = CharacterDetailModel.ComicDetail.ViewModel()
        
        viewController?.displayComicDetailsView(viewModel: viewModel)
    }
}
