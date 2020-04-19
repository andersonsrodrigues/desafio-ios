//
//  ComicDetailWorkerTests.swift
//  desafio-ios-anderson-rodrigues
//
//  Created by Anderson Rodrigues on 16/04/2020.
//  Copyright (c) 2020 Anderson Rodrigues. All rights reserved.
//

@testable import desafio_ios_anderson_rodrigues
import XCTest

class ComicDetailWorkerTests: XCTestCase {
	// MARK: Subject under test
	
	var sut: ComicDetailWorker!
	
	// MARK: Test lifecycle
	
	override func setUp() {
		super.setUp()
		setupComicDetailWorker()
	}
	
	override func tearDown() {
		super.tearDown()
	}
	
	// MARK: Test setup
	
	func setupComicDetailWorker() {
		sut = ComicDetailWorker()
	}
	
	// MARK: Tests
    
    func testFetchComicDetail() {
        let setupExpectation = expectation(description: "set up completion called")
        var data = ComicDetailModel.Comic.Response()
        
        // Given
        let indexPath = IndexPath(row: 0, section: 0)
        let characterWorker = CharacterListModel.characterWorker
        let character = characterWorker.read(at: indexPath)
        
        // When
        sut.fetchComicDetail(character: character) { response in
            data = response
            setupExpectation.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: 10.0) { (_) in
            XCTAssertNotNil(data.comic)
        }
    }
    
    func testFetchCoverImage() {
        let setupExpectation = expectation(description: "set up completion called")
        var data = ComicDetailModel.CoverImage.Response(image: nil, error: nil)
        
        // Given
        let request = ComicDetailModel.CoverImage.Request(url: Seed.ComicSeed.a.thumbnail!.path!, size: .landscapeAmazing, ext: Seed.ComicSeed.a.thumbnail!.extension!)
        
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
}
