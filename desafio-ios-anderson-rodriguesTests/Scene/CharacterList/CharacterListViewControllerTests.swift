//
//  CharacterListViewControllerTests.swift
//  desafio-ios-anderson-rodrigues
//
//  Created by Anderson Rodrigues on 16/04/2020.
//  Copyright (c) 2020 Anderson Rodrigues. All rights reserved.
//

@testable import desafio_ios_anderson_rodrigues
import XCTest

class CharacterListViewControllerTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: CharacterListViewController!
    var window: UIWindow!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupCharacterListViewController()
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupCharacterListViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "CharacterListViewController") as? CharacterListViewController
    }
    
    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: Test doubles
    
    class CharacterListBusinessLogicSpy: CharacterListBusinessLogic {
        var requestCharacterList = false
        var requestRefreshCharacterList = false
        var requestCharacterThumbnail = false
        var fetchCharacterRow = false
        var countData = false
        var startCharacterUpdates = false
        var stopCharacterUpdates = false
        var provideDataStoreToCharacterDetail = false
        var requestPageInfo = false
        
        func requestCharacterList(request: CharacterListModel.Character.Request) {
            requestCharacterList = true
        }
        
        func requestRefreshCharacterList(request: CharacterListModel.Character.Request) {
            requestRefreshCharacterList = true
        }
        
        func requestCharacterThumbnail(request: CharacterListModel.CoverImage.Request) {
            requestCharacterThumbnail = true
        }
        
        func fetchCharacterRow(request: CharacterListModel.FetchCharacterRowAndConfigureCell.Request) {
            fetchCharacterRow = true
        }
        
        func count() -> Int {
            countData = true
            
            return 1
        }
        
        func startCharacterUpdates(request: CharacterListModel.StartCharacterListUpdates.Request) {
            startCharacterUpdates = true
        }
        
        func stopCharacterUpdates(request: CharacterListModel.StopCharacterListUpdates.Request) {
            stopCharacterUpdates = true
        }
        
        func provideDataStoreToCharacterDetail(request: CharacterListModel.CharacterDetail.Request) {
            provideDataStoreToCharacterDetail = true
        }
        
        func requestPageInfo(request: CharacterListModel.CharacterPage.Request) {
            requestPageInfo = true
        }
    }
    
    // MARK: Tests
    
    func testShouldRequestCharacterListWhenViewIsLoaded() {
        // Given
        let spy = CharacterListBusinessLogicSpy()
        sut.interactor = spy
        
        // When
        loadView()
        
        // Then
        XCTAssertTrue(spy.requestCharacterList, "requestCharacterList() should ask the interactor to request character list")
    }
    
    func testShouldRequestRefreshCharacterListWhenPushCollectionToRefresh() {
        // Given
        let spy = CharacterListBusinessLogicSpy()
        sut.interactor = spy
        
        // When
        loadView()
        sut.handleRefreshControl()
        
        // Then
        XCTAssertTrue(spy.requestRefreshCharacterList, "requestRefreshCharacterList() should ask the interactor to refresh the character list")
    }
    
    func testShouldRequestPageInfo() {
        // Given
        let spy = CharacterListBusinessLogicSpy()
        sut.interactor = spy
        
        // When
        loadView()
        
        // Then
        XCTAssertTrue(spy.requestPageInfo, "loadView() should ask the interactor to return the number of items")
    }
}
