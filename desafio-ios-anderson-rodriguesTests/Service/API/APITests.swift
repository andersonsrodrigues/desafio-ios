//
//  APITests.swift
//  desafio-ios-anderson-rodriguesTests
//
//  Created by Anderson Rodrigues on 16/04/2020.
//  Copyright © 2020 Anderson Rodrigues. All rights reserved.
//

@testable import desafio_ios_anderson_rodrigues
import XCTest

class APITests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override class func tearDown() {
        super.tearDown()
    }

    func testGetAllCharacters() {
        let characterExpectation = expectation(description: "All Characters")
        var characterResponse: DataContainer<CharacterData>?
        
        APIClient.getAllCharacters(on: 0) { (data, error) in
            characterResponse = data
            characterExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10.0) { (error) in
            XCTAssertNotNil(characterResponse)
        }
    }
    
    func testGetAllComics() {
        let characterID = Seed.CharacterSeed.a.id!
        let comicExpectation = expectation(description: "All Comics")
        var comicResponse: [ComicData]?
        
        APIClient.getAllComics(by: characterID) { (data, error) in
            comicResponse = data
            comicExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10.0) { (error) in
            XCTAssertNotNil(comicResponse)
        }
    }
    
    func testDownloadThumbnailImage() {
        let thumbnailData = Seed.CharacterSeed.a.thumbnail!
        let thumbnailExpectation = expectation(description: "Poster")
        var thumbnailResponse: Data?
        
        APIClient.downloadPosterImage(path: thumbnailData.path!, size: .landscapeAmazing, ext: thumbnailData.extension!) { (data, error) in
            thumbnailResponse = data
            thumbnailExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10.0) { (error) in
            XCTAssertNotNil(thumbnailResponse)
        }
    }
}
