//
//  CharacterListInteractorTests.swift
//  desafio-ios-anderson-rodrigues
//
//  Created by Anderson Rodrigues on 16/04/2020.
//  Copyright (c) 2020 Anderson Rodrigues. All rights reserved.
//

@testable import desafio_ios_anderson_rodrigues
import XCTest

class CharacterListInteractorTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: CharacterListInteractor!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupCharacterListInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupCharacterListInteractor() {
        sut = CharacterListInteractor()
    }
    
    // MARK: Test doubles
    
    class CharacterListPresentationLogicSpy: CharacterListPresentationLogic {
        var presentCharacterList = false
        var presentCharacterThumbnail = false
        var presentCharacterDetailView = false
        var presentFetchedCharacterRowAndConfigureCell = false
        var presentInsertRow = false
        var presentDeleteRow = false
        var presentUpdatedRow = false
        var presentMoveRow = false
        var presentPagesInfo = false
        
        func presentCharacterList(response: CharacterListModel.Character.Response) {
            presentCharacterList = true
        }
        
        func presentCharacterThumbnail(response: CharacterListModel.CoverImage.Response) {
            presentCharacterThumbnail = true
        }
        
        func presentCharacterDetailView(response: CharacterListModel.CharacterDetail.Response) {
            presentCharacterDetailView = true
        }
        
        func presentFetchedCharacterRowAndConfigureCell(response: CharacterListModel.FetchCharacterRowAndConfigureCell.Response) {
            presentFetchedCharacterRowAndConfigureCell = true
        }
        
        func presentInsertRow(at indexPath: IndexPath) {
            presentInsertRow = true
        }
        
        func presentDeleteRow(at indexPath: IndexPath) {
            presentDeleteRow = true
        }
        
        func presentUpdatedRow(at indexPath: IndexPath, withCharacter character: CharacterMarvel) {
            presentUpdatedRow = true
        }
        
        func presentMoveRow(from: IndexPath, to: IndexPath, withCharacter character: CharacterMarvel) {
            presentMoveRow = true
        }
        
        func presentPagesInfo(response: CharacterListModel.CharacterPage.Response) {
            presentPagesInfo = true
        }
    }
    
    // MARK: Tests
    
    func testRequestFetchCharacterRow() {
        // Given
        let spy = CharacterListPresentationLogicSpy()
        sut.presenter = spy
        let indexPath = IndexPath(row: 0, section: 0)
        let request = CharacterListModel.FetchCharacterRowAndConfigureCell.Request(indexPath: indexPath, cell: nil)
        
        // When
        sut.fetchCharacterRow(request: request)
        
        // Then
        XCTAssertTrue(spy.presentFetchedCharacterRowAndConfigureCell, "requestCharacterList(request:) should ask the presenter to format the result")
    }
    
    func testRequestProvideDataStoreToCharacterDetail() {
        // Given
        let spy = CharacterListPresentationLogicSpy()
        sut.presenter = spy
        let indexPath = IndexPath(row: 0, section: 0)
        let request = CharacterListModel.CharacterDetail.Request(indexPath: indexPath)
        
        // When
        sut.provideDataStoreToCharacterDetail(request: request)
        
        // Then
        XCTAssertTrue(spy.presentCharacterDetailView, "requestCharacterList(request:) should ask the presenter to format the result")
    }
    
    func testRequestPageInfo() {
        // Given
        let spy = CharacterListPresentationLogicSpy()
        sut.presenter = spy
        let request = CharacterListModel.CharacterPage.Request()
        
        // When
        sut.requestPageInfo(request: request)
        
        // Then
        XCTAssertTrue(spy.presentPagesInfo, "requestCharacterList(request:) should ask the presenter to format the result")
    }
}
