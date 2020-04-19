//
//  CharacterDetailInteractorTests.swift
//  desafio-ios-anderson-rodrigues
//
//  Created by Anderson Rodrigues on 16/04/2020.
//  Copyright (c) 2020 Anderson Rodrigues. All rights reserved.
//

@testable import desafio_ios_anderson_rodrigues
import XCTest

class CharacterDetailInteractorTests: XCTestCase {
	// MARK: Subject under test
	
	var sut: CharacterDetailInteractor!
	
	// MARK: Test lifecycle
	
	override func setUp() {
		super.setUp()
		setupCharacterDetailInteractor()
	}
	
	override func tearDown() {
		super.tearDown()
	}
	
	// MARK: Test setup
	
	func setupCharacterDetailInteractor() {
		sut = CharacterDetailInteractor()
	}
	
	// MARK: Test doubles
	
    class CharacterDetailPresentationLogicSpy: CharacterDetailPresentationLogic {
        
        var presentCharacterDetail = false
        var presentComicDetailView = false
        
        func presentCharacterDetail(response: CharacterDetailModel.Character.Response) {
            presentCharacterDetail = true
        }
        
        func presentComicDetailView(response: CharacterDetailModel.ComicDetail.Response) {
            presentComicDetailView = true
        }
	}
	
	// MARK: Tests
	
	func testRequestCharacteDetail() {
		// Given
		let spy = CharacterDetailPresentationLogicSpy()
		sut.presenter = spy
		let request = CharacterDetailModel.Character.Request()
		
		// When
		sut.requestCharacteDetail(request: request)
		
		// Then
		XCTAssertTrue(spy.presentCharacterDetail, "requestCharacteDetail(request:) should ask the presenter to format the result")
	}
    
    func testProvideDataStoreToComicDetail() {
        // Given
        let spy = CharacterDetailPresentationLogicSpy()
        sut.presenter = spy
        let request = CharacterDetailModel.ComicDetail.Request()
        
        // When
        sut.provideDataStoreToComicDetail(request: request)
        
        // Then
        XCTAssertTrue(spy.presentComicDetailView, "provideDataStoreToComicDetail(request:) should ask the presenter to format the result")
    }
}
