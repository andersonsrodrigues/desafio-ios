//
//  CharacterListWorkerTests.swift
//  desafio-ios-anderson-rodrigues
//
//  Created by Anderson Rodrigues on 16/04/2020.
//  Copyright (c) 2020 Anderson Rodrigues. All rights reserved.
//

@testable import desafio_ios_anderson_rodrigues
import XCTest

class MockUserDefaults: UserDefaults {
    var setCurrentPage = false
    var setOffsetPage = false
    var setTotalPage = false
    
    var getCurrentPage = false
    var getOffsetPage = false
    var getTotalPage = false
    
    override func integer(forKey defaultName: String) -> Int {
        if defaultName == "currentPage" {
            getCurrentPage = true
        } else if defaultName == "offsetPage" {
            getOffsetPage = true
        } else if defaultName == "totalPage" {
            getTotalPage = true
        }
        
        return 10
    }
    
    override func set(_ value: Int, forKey defaultName: String) {
        if defaultName == "currentPage" {
            setCurrentPage = true
        } else if defaultName == "offsetPage" {
            setOffsetPage = true
        } else if defaultName == "totalPage" {
            setTotalPage = true
        }
    }
}

class CharacterListWorkerTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: CharacterListWorker!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupCharacterListWorker()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupCharacterListWorker() {
        sut = CharacterListWorker()
    }
    
    // MARK: Test doubles
    let page = CharacterListModel.Page(current: 1, offset: 20, total: 20)
    
    // MARK: Tests
    
    func testFetchCharacterList() {
        let setupExpectation = expectation(description: "set up completion called")
        var data = CharacterListModel.Character.Response(character: [], page: page, error: nil)
        
        // Given
        let request = CharacterListModel.Character.Request(page: page)
        
        // When
        sut.fetchCharacterList(request: request) { response in
            data = response
            setupExpectation.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: 10.0) { (_) in
            XCTAssertTrue(data.character.count > 0, "")
        }
    }
    
    func testRefreshCharacterList() {
        let setupExpectation = expectation(description: "set up completion called")
        var data = CharacterListModel.Character.Response(character: [], page: page, error: nil)
        
        // Given
        let request = CharacterListModel.Character.Request(page: page)
        
        // When
        sut.fetchRefreshCharacterList(request: request) { response in
            data = response
            setupExpectation.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: 10.0) { (_) in
            XCTAssertTrue(data.character.count > 0, "")
        }
    }
    
    func testFetchCoverImage() {
        let setupExpectation = expectation(description: "set up completion called")
        var data = CharacterListModel.CoverImage.Response(image: nil, cell: CharacterCollectionViewCell(), error: nil)
        
        // Given
        let request = CharacterListModel.CoverImage.Request(url: Seed.CharacterSeed.a.thumbnail!.path!, size: .landscapeAmazing, ext: Seed.CharacterSeed.a.thumbnail!.extension!, indexPath: IndexPath(row: 0, section: 0), cell: CharacterCollectionViewCell())
        
        // When
        sut.fetchCoverImage(request: request) { response in
            data = response
            setupExpectation.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: 10.0) { (_) in
            XCTAssertNotNil(data.image)
        }
    }
    
    func testSetCurrentPage() {
        // Given
        let mockUserDefaults = MockUserDefaults(suiteName: "testing")!
        sut.userDefaults = mockUserDefaults
        
        // When
        sut.setCurrent(page: 1)
        
        // Then
        XCTAssertTrue(mockUserDefaults.setCurrentPage, "Current Page should be set to the User Defaults")
    }
    
    func testSetOffsetPage() {
        // Given
        let mockUserDefaults = MockUserDefaults(suiteName: "testing")!
        sut.userDefaults = mockUserDefaults
        
        // When
        sut.setOffset(page: 1)
        
        // Then
        XCTAssertTrue(mockUserDefaults.setOffsetPage, "Offset Page should be set to the User Defaults")
    }
    
    func testSetTotalPage() {
        // Given
        let mockUserDefaults = MockUserDefaults(suiteName: "testing")!
        sut.userDefaults = mockUserDefaults
        
        // When
        sut.setTotal(pages: 1)
        
        // Then
        XCTAssertTrue(mockUserDefaults.setTotalPage, "Total Pages should be set to the User Defaults")
    }
    
    func testGetCurrentPage() {
        // Given
        let mockUserDefaults = MockUserDefaults(suiteName: "testing")!
        sut.userDefaults = mockUserDefaults
        
        // When
        let value = sut.getCurrentPage()
        
        // Then
        XCTAssertTrue(mockUserDefaults.getCurrentPage, "Current Page should be get from the User Defaults")
        XCTAssertEqual(value, 10)
    }
    
    func testGetOffsetPage() {
        // Given
        let mockUserDefaults = MockUserDefaults(suiteName: "testing")!
        sut.userDefaults = mockUserDefaults
        
        // When
        let value = sut.getOffsetPage()
        
        // Then
        XCTAssertTrue(mockUserDefaults.getOffsetPage, "Offset Page should be get from the User Defaults")
        XCTAssertEqual(value, 10)
    }
    
    func testGetTotalPage() {
        // Given
        let mockUserDefaults = MockUserDefaults(suiteName: "testing")!
        sut.userDefaults = mockUserDefaults
        
        // When
        let value = sut.getTotalPage()
        
        // Then
        XCTAssertTrue(mockUserDefaults.getTotalPage, "Total Pages should be get from the User Defaults")
        XCTAssertEqual(value, 10)
    }
}
