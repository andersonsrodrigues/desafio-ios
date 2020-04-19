//
//  ComicDetailPresenter.swift
//  desafio-ios-anderson-rodrigues
//
//  Created by Anderson Rodrigues on 16/04/2020.
//  Copyright (c) 2020 Anderson Rodrigues. All rights reserved.
//

import UIKit

// MARK: - Protocol
protocol ComicDetailPresentationLogic {
    // MARK: Present Methods
	func presentComicDetail(response: ComicDetailModel.Comic.Response)
    func presentCoverThumbnail(response: ComicDetailModel.CoverImage.Response)
}

class ComicDetailPresenter: ComicDetailPresentationLogic {
	weak var viewController: ComicDetailDisplayLogic?
	
	// MARK: Present Methods
	
	func presentComicDetail(response: ComicDetailModel.Comic.Response) {
        let viewModel = ComicDetailModel.Comic.ViewModel(comic: response.comic, error: response.error)
		
        if let _ = response.error {
            viewController?.displayErrorComicDetail(viewModel: viewModel)
        } else {
            viewController?.displayComicDetail(viewModel: viewModel)
        }
	}
    
    func presentCoverThumbnail(response: ComicDetailModel.CoverImage.Response) {
        if let _ = response.error {
            let viewModel = ComicDetailModel.CoverImage.ViewModel(displayedImage: nil, error: response.error)
            viewController?.displayErrorComicThumbnail(viewModel: viewModel)
        } else {
            let displayImage = convert(data: response.image!)
            let viewModel = ComicDetailModel.CoverImage.ViewModel(displayedImage: displayImage, error: response.error)
            viewController?.displayComicThumbnail(viewModel: viewModel)
        }
    }
    
    // MARK: - Format data to displayed entry
    
    private func convert(data: Data) -> ComicDetailModel.DisplayedImage? {
        if let image = UIImage(data: data) {
            return ComicDetailModel.DisplayedImage(cover: image)
        } else {
            return nil
        }
    }
}
