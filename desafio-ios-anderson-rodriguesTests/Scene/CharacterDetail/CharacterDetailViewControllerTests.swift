//
//  CharacterDetailViewControllerTests.swift
//  desafio-ios-anderson-rodrigues
//
//  Created by Anderson Rodrigues on 16/04/2020.
//  Copyright (c) 2020 Anderson Rodrigues. All rights reserved.
//

@testable import desafio_ios_anderson_rodrigues
import XCTest

class CharacterDetailViewControllerTests: XCTestCase {
	// MARK: Subject under test
	
	var sut: CharacterDetailViewController!
	var window: UIWindow!
	
	// MARK: Test lifecycle
	
	override func setUp() {
		super.setUp()
		window = UIWindow()
		setupCharacterDetailViewController()
	}
	
	override func tearDown() {
		window = nil
		super.tearDown()
	}
	
	// MARK: Test setup
	
	func setupCharacterDetailViewController() {
		let bundle = Bundle.main
		let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "CharacterDetailViewController") as? CharacterDetailViewController
	}
	
	func loadView() {
		window.addSubview(sut.view)
		RunLoop.current.run(until: Date())
	}
	
	// MARK: Test doubles
	
    class CharacterDetailBusinessLogicSpy: CharacterDetailBusinessLogic {
        
        var requestCharacteDetail = true
        var provideDataStoreToComicDetail = false
        
        func requestCharacteDetail(request: CharacterDetailModel.Character.Request) {
            requestCharacteDetail = true
        }
        
        func provideDataStoreToComicDetail(request: CharacterDetailModel.ComicDetail.Request) {
            provideDataStoreToComicDetail = true
        }
	}
	
	// MARK: Tests
	
	func testShouldRequestCharacterDetail() {
		// Given
		let spy = CharacterDetailBusinessLogicSpy()
		sut.interactor = spy
		
		// When
		loadView()
		
		// Then
		XCTAssertTrue(spy.requestCharacteDetail, "viewDidLoad() should ask the interactor to do something")
	}
    
    func testRquestComicDescView() {
        // Given
        let spy = CharacterDetailBusinessLogicSpy()
        sut.interactor = spy
        
        // When
        loadView()
        sut.comicHQButton.sendActions(for: .touchUpInside)
        
        // Then
        XCTAssertTrue(spy.provideDataStoreToComicDetail, "requestComicDescView() should ask the interactor to do something")
    }
}
