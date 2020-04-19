//
//  ComicDetailPresenterTests.swift
//  desafio-ios-anderson-rodrigues
//
//  Created by Anderson Rodrigues on 16/04/2020.
//  Copyright (c) 2020 Anderson Rodrigues. All rights reserved.
//

@testable import desafio_ios_anderson_rodrigues
import XCTest

class ComicDetailPresenterTests: XCTestCase {
	// MARK: Subject under test
	
	var sut: ComicDetailPresenter!
	
	// MARK: Test lifecycle
	
	override func setUp() {
		super.setUp()
		setupComicDetailPresenter()
	}
	
	override func tearDown() {
		super.tearDown()
	}
	
	// MARK: Test setup
	
	func setupComicDetailPresenter() {
		sut = ComicDetailPresenter()
        
        let indexPath = IndexPath(row: 0, section: 0)
        let characterWorker = CharacterListModel.characterWorker
        let character = characterWorker.read(at: indexPath)
        
        let comicWorker = ComicDetailModel.comicWorker
        comicWorker.setupFetchedResultsController(character: character)
        
        let comic = Seed.ComicSeed.b
        comicWorker.create(obj: comic)
	}
	
	// MARK: Test doubles
	
    class ComicDetailDisplayLogicSpy: ComicDetailDisplayLogic {
        
        var displayComicDetail = false
        var displayComicThumbnail = false
        var displayErrorComicDetail = false
        var displayErrorComicThumbnail = false
        
        func displayComicDetail(viewModel: ComicDetailModel.Comic.ViewModel) {
            displayComicDetail = true
        }
        
        func displayComicThumbnail(viewModel: ComicDetailModel.CoverImage.ViewModel) {
            displayComicThumbnail = true
        }
        
        func displayErrorComicDetail(viewModel: ComicDetailModel.Comic.ViewModel) {
            displayErrorComicDetail = true
        }
        
        func displayErrorComicThumbnail(viewModel: ComicDetailModel.CoverImage.ViewModel) {
            displayErrorComicThumbnail = true
        }
	}
	
	// MARK: Tests
	
	func testPresentComicDetailSuccess() {
		// Given
		let spy = ComicDetailDisplayLogicSpy()
		sut.viewController = spy
        let indexPath = IndexPath(row: 0, section: 0)
        let characterWorker = CharacterListModel.characterWorker
        let character = characterWorker.read(at: indexPath)
        
        let comicWorker = ComicDetailModel.comicWorker
        comicWorker.setupFetchedResultsController(character: character)
        
        let comic = comicWorker.read(at: indexPath)
		let response = ComicDetailModel.Comic.Response(comic: comic, error: nil)
		
		// When
		sut.presentComicDetail(response: response)
		
		// Then
		XCTAssertTrue(spy.displayComicDetail, "presentComicDetail(response:) should ask the view controller to display the result")
	}
    
    func testPresentComicDetailFail() {
        // Given
        let spy = ComicDetailDisplayLogicSpy()
        sut.viewController = spy
        let response = ComicDetailModel.Comic.Response(comic: nil, error: "Message Test")
        
        // When
        sut.presentComicDetail(response: response)
        
        // Then
        XCTAssertTrue(spy.displayErrorComicDetail, "presentComicDetail(response:) should ask the view controller to display the result")
    }
    
    func testPresentCoverThumbnailSuccess() {
        // Given
        let spy = ComicDetailDisplayLogicSpy()
        sut.viewController = spy
        let response = ComicDetailModel.CoverImage.Response(image: Data(), error: nil)
        
        // When
        sut.presentCoverThumbnail(response: response)
        
        // Then
        XCTAssertTrue(spy.displayComicThumbnail, "presentComicDetail(response:) should ask the view controller to display the result")
    }
    
    func testPresentCoverThumbnailFail() {
        // Given
        let spy = ComicDetailDisplayLogicSpy()
        sut.viewController = spy
        let response = ComicDetailModel.CoverImage.Response(image: nil, error: "Message Test")
        
        // When
        sut.presentCoverThumbnail(response: response)
        
        // Then
        XCTAssertTrue(spy.displayErrorComicThumbnail, "presentComicDetail(response:) should ask the view controller to display the result")
    }
}
