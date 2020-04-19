//
//  CharacterListPresenterTests.swift
//  desafio-ios-anderson-rodrigues
//
//  Created by Anderson Soares Rodrigues on 18/04/20.
//  Copyright (c) 2020 Anderson Rodrigues. All rights reserved.
//

@testable import desafio_ios_anderson_rodrigues
import XCTest

class CharacterListPresenterTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: CharacterListPresenter!
    var spy: CharacterListDisplayLogicSpy!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupCharacterListPresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupCharacterListPresenter() {
        sut = CharacterListPresenter()
        spy = CharacterListDisplayLogicSpy()
        sut.viewController = spy
        
    }
    
    // MARK: Test doubles
    
    class CharacterListDisplayLogicSpy: CharacterListDisplayLogic {
        var displayCharacterList = false
        var displayCharacterThumbnail = false
        var displayErrorCharacterList = false
        var displayErrorCharacterThumbnail = false
        var displayInsertedRow = false
        var displayDeletedRow = false
        var displayUpdatedRow = false
        var displayMovedRow = false
        var displayFetchedCharacterRowAndConfigureCell = false
        var displayCharacterDetailsView = false
        var displayPageInfo = false
        
        func displayCharacterList(viewModel: CharacterListModel.Character.ViewModel) {
            displayCharacterList = true
        }
        
        func displayCharacterThumbnail(viewModel: CharacterListModel.CoverImage.ViewModel) {
            displayCharacterThumbnail = true
        }
        
        func displayErrorCharacterList(viewModel: CharacterListModel.Character.ViewModel) {
            displayErrorCharacterList = true
        }
        
        func displayErrorCharacterThumbnail(viewModel: CharacterListModel.CoverImage.ViewModel) {
            displayErrorCharacterThumbnail = true
        }
        
        func displayInsertedRow(at: IndexPath) {
            displayInsertedRow = true
        }
        
        func displayDeletedRow(at: IndexPath) {
            displayDeletedRow = true
        }
        
        func displayUpdatedRow(at: IndexPath, withDisplayedCharacter displayedCharacter: CharacterListModel.DisplayedCell) {
            displayUpdatedRow = true
        }
        
        func displayMovedRow(from: IndexPath, to: IndexPath, withDisplayedCharacter displayedCharacter: CharacterListModel.DisplayedCell) {
            displayMovedRow = true
        }
        
        func displayFetchedCharacterRowAndConfigureCell(viewModel: CharacterListModel.FetchCharacterRowAndConfigureCell.ViewModel) {
            displayFetchedCharacterRowAndConfigureCell = true
        }
        
        func displayCharacterDetailsView(viewModel: CharacterListModel.CharacterDetail.ViewModel) {
            displayCharacterDetailsView = true
        }
        
        func displayPageInfo(viewModel: CharacterListModel.CharacterPage.ViewModel) {
            displayPageInfo = true
        }
    }
    
    // MARK: Tests
    
    func testPresentCharacterListSuccess() {
        // Given
        let response = CharacterListModel.Character.Response(character: [], page: CharacterListModel.Page(current: 1, offset: 20, total: 150), error: nil)
        
        // When
        sut.presentCharacterList(response: response)
        
        // Then
        XCTAssertTrue(spy.displayCharacterList, "presentCharacterList(response:) should ask the view controller to display the result")
    }
    
    func testPresentCharacterListFailToShowPresentErrorCharacterList() {
        // Given
        let response = CharacterListModel.Character.Response(character: [], page: CharacterListModel.Page(current: 1, offset: 20, total: 150), error: "Message test")
        
        // When
        sut.presentCharacterList(response: response)
        
        // Then
        XCTAssertTrue(spy.displayErrorCharacterList, "presentCharacterList(response:) should ask the view controller to display the result")
    }
    
    func testPresentCharacterThumbnailSuccess() {
        // Given
        let response = CharacterListModel.CoverImage.Response(image: Data(), cell: CharacterCollectionViewCell(), error: nil)
        
        // When
        sut.presentCharacterThumbnail(response: response)
        
        // Then
        XCTAssertTrue(spy.displayCharacterThumbnail, "presentCharacterThumbnail(response:) should ask the view controller to display the result")
    }
    
    func testPresentCharacterThumbnailFailToShowPresentErrorCharacterThumbnail() {
        // Given
        let response = CharacterListModel.CoverImage.Response(image: Data(), cell: CharacterCollectionViewCell(), error: "Message test")
        
        // When
        sut.presentCharacterThumbnail(response: response)
        
        // Then
        XCTAssertTrue(spy.displayErrorCharacterThumbnail, "presentCharacterThumbnail(response:) should ask the view controller to display the result")
    }
    
    func testPresentPageInfo() {
        // Given
        let response = CharacterListModel.CharacterPage.Response(current: 1, offset: 20, total: 20)
        
        // When
        sut.presentPagesInfo(response: response)
        
        // Then
        XCTAssertTrue(spy.displayPageInfo, "presentPagesInfo(response:) should ask the view controller to display the result")
    }
    
    func testPresentInsertRow() {
        // Given
        let indexPath = IndexPath(row: 0, section: 0)
        
        // When
        sut.presentInsertRow(at: indexPath)
        
        // Then
        XCTAssertTrue(spy.displayInsertedRow, "presentInsertRow(response:) should ask the view controller to display the result")
    }
    
    func testPresentDeleteRow() {
        // Given
        let indexPath = IndexPath(row: 0, section: 0)
        
        // When
        sut.presentDeleteRow(at: indexPath)
        
        // Then
        XCTAssertTrue(spy.displayDeletedRow, "presentDeleteRow(response:) should ask the view controller to display the result")
    }
    
    func testPresentUpdatedRow() {
        // Given
        let indexPath = IndexPath(row: 0, section: 0)
        let characterWorker = CharacterListModel.characterWorker
        let character = characterWorker.read(at: indexPath)
        
        // When
        sut.presentUpdatedRow(at: indexPath, withCharacter: character)
        
        // Then
        XCTAssertTrue(spy.displayUpdatedRow, "presentDeleteRow(response:) should ask the view controller to display the result")
    }
    
    func testPresentMoveRow() {
        // Given
        let fromIndexPath = IndexPath(row: 0, section: 0)
        let toIndexPath = IndexPath(row: 1, section: 0)
        let characterWorker = CharacterListModel.characterWorker
        let character = characterWorker.read(at: toIndexPath)
        
        // When
        sut.presentMoveRow(from: fromIndexPath, to: toIndexPath, withCharacter: character)
        
        // Then
        XCTAssertTrue(spy.displayMovedRow, "presentDeleteRow(response:) should ask the view controller to display the result")
    }
    
    func testPresentFetchedCharacterRowAndConfigureCell() {
        // Given
        let indexPath = IndexPath(row: 0, section: 0)
        let characterWorker = CharacterListModel.characterWorker
        let character = characterWorker.read(at: indexPath)
        let response = CharacterListModel.FetchCharacterRowAndConfigureCell.Response(character: character, cell: CharacterCollectionViewCell(), indexPath: indexPath)
        
        // When
        sut.presentFetchedCharacterRowAndConfigureCell(response: response)
        
        // Then
        XCTAssertTrue(spy.displayFetchedCharacterRowAndConfigureCell, "presentCharacterThumbnail(response:) should ask the view controller to display the result")
    }
    
    func testPresentCharacterDetailView() {
        // Given
        let response = CharacterListModel.CharacterDetail.Response()
        
        // When
        sut.presentCharacterDetailView(response: response)
        
        // Then
        XCTAssertTrue(spy.displayCharacterDetailsView, "presentCharacterThumbnail(response:) should ask the view controller to display the result")
    }
}
