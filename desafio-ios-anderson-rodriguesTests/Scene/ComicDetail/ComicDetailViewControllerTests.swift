//
//  ComicDetailViewControllerTests.swift
//  desafio-ios-anderson-rodrigues
//
//  Created by Anderson Rodrigues on 16/04/2020.
//  Copyright (c) 2020 Anderson Rodrigues. All rights reserved.
//

@testable import desafio_ios_anderson_rodrigues
import XCTest

class ComicDetailViewControllerTests: XCTestCase {
	// MARK: Subject under test
	
	var sut: ComicDetailViewController!
	var window: UIWindow!
	
	// MARK: Test lifecycle
	
	override func setUp() {
		super.setUp()
		window = UIWindow()
		setupComicDetailViewController()
	}
	
	override func tearDown() {
		window = nil
		super.tearDown()
	}
	
	// MARK: Test setup
	
	func setupComicDetailViewController() {
		let bundle = Bundle.main
		let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "ComicDetailViewController") as? ComicDetailViewController
	}
	
	func loadView() {
		window.addSubview(sut.view)
		RunLoop.current.run(until: Date())
	}
	
	// MARK: Test doubles
	
    class ComicDetailBusinessLogicSpy: ComicDetailBusinessLogic {
        
        var requestComicDetail = false
        var requestComicThumbnail = false
        
        func requestComicDetail(request: ComicDetailModel.Comic.Request) {
            requestComicDetail = true
        }
        
        func requestComicThumbnail(request: ComicDetailModel.CoverImage.Request) {
            requestComicThumbnail = true
        }
	}
	
	// MARK: Tests
	
	func testShouldRequestComicDetail() {
		// Given
		let spy = ComicDetailBusinessLogicSpy()
		sut.interactor = spy
		
		// When
		loadView()
		
		// Then
		XCTAssertTrue(spy.requestComicDetail, "viewDidLoad() should ask the interactor to do something")
	}
    
    func testShouldRequestComicThumbnail() {
        // Given
        let spy = ComicDetailBusinessLogicSpy()
        sut.interactor = spy
        let thumbnail = Seed.ComicSeed.a.thumbnail!
        
        // When
        loadView()
        sut.requestComicThumbnail(url: thumbnail.path!, ext: thumbnail.extension!)
        
        // Then
        XCTAssertTrue(spy.requestComicThumbnail, "viewDidLoad() should ask the interactor to do something")
    }
}
