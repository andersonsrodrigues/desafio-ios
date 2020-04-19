//
//  CharacterDetailPresenterTests.swift
//  desafio-ios-anderson-rodrigues
//
//  Created by Anderson Rodrigues on 16/04/2020.
//  Copyright (c) 2020 Anderson Rodrigues. All rights reserved.
//

@testable import desafio_ios_anderson_rodrigues
import XCTest

class CharacterDetailPresenterTests: XCTestCase {
	// MARK: Subject under test
	
	var sut: CharacterDetailPresenter!
	
	// MARK: Test lifecycle
	
	override func setUp() {
		super.setUp()
		setupCharacterDetailPresenter()
	}
	
	override func tearDown() {
		super.tearDown()
	}
	
	// MARK: Test setup
	
	func setupCharacterDetailPresenter() {
		sut = CharacterDetailPresenter()
	}
	
	// MARK: Test doubles
	
    class CharacterDetailDisplayLogicSpy: CharacterDetailDisplayLogic {
        
        var displayCharacterDetail = false
        var displayComicDetailsView = false
        
        func displayCharacterDetail(viewModel: CharacterDetailModel.Character.ViewModel) {
            displayCharacterDetail = true
        }
        
        func displayComicDetailsView(viewModel: CharacterDetailModel.ComicDetail.ViewModel) {
            displayComicDetailsView = true
        }
	}
	
	// MARK: Tests
	
	func testPresentCharacterDetail() {
		// Given
        let indexPath = IndexPath(row: 0, section: 0)
        let characterWorker = CharacterListModel.characterWorker
        let character = characterWorker.read(at: indexPath)
		let spy = CharacterDetailDisplayLogicSpy()
		sut.viewController = spy
        let response = CharacterDetailModel.Character.Response(character: character)
		
		// When
		sut.presentCharacterDetail(response: response)
		
		// Then
		XCTAssertTrue(spy.displayCharacterDetail, "presentCharacterDetail(response:) should ask the view controller to display the result")
	}
    
    func testPresentComicDetailView() {
        // Given
        let spy = CharacterDetailDisplayLogicSpy()
        sut.viewController = spy
        let response = CharacterDetailModel.ComicDetail.Response()
        
        // When
        sut.presentComicDetailView(response: response)
        
        // Then
        XCTAssertTrue(spy.displayComicDetailsView, "presentComicDetailView(response:) should ask the view controller to display the result")
    }
}
