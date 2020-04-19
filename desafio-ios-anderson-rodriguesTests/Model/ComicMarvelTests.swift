//
//  ComicMarvelTests.swift
//  desafio-ios-anderson-rodriguesTests
//
//  Created by Anderson Rodrigues on 16/04/2020.
//  Copyright © 2020 Anderson Rodrigues. All rights reserved.
//

@testable import desafio_ios_anderson_rodrigues
import XCTest

class ComicMarvelTests: XCTestCase {
    
    var sut: ComicData!
    var comicWorker: ComicCoreDataWorker!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupComicSeed()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupComicSeed() {
        let indexPath = IndexPath(row: 0, section: 0)
        let characterWorker = CharacterListModel.characterWorker
        let character = characterWorker.read(at: indexPath)
        
        comicWorker = ComicDetailModel.comicWorker
        comicWorker.setupFetchedResultsController(character: character)
        
        sut = Seed.ComicSeed.b
        comicWorker.create(obj: sut)
    }
    
    func testJSONParseToComic() throws {
        // Given
        let json = Seed.ComicJSON.data
        let decoder = JSONDecoder()
        
        // When
        do {
            let comic: ComicData = try decoder.decode(ComicData.self, from: json)

            // Then
            XCTAssertEqual(comic.id, 22506)
            XCTAssertEqual(comic.title, "Avengers: The Initiative (2007) #19")
        } catch {
            print(error)
        }
    }
    
    func testHighValueOfHQSuccess() throws {
        XCTAssertEqual(sut.highestPrice(), 580.0)
    }
    
    func testHighValueOfHQFail() throws {
        XCTAssertNotEqual(sut.highestPrice(), 240.0)
    }

    func testHQMExpensiveSuccess() throws {
        // Given
        var arrayComic = [ComicData]()
        
        // When
        arrayComic.append(Seed.ComicSeed.b)
        arrayComic.append(Seed.ComicSeed.c)
        
        let hqMaisCara = arrayComic.sorted().first
        
        // Then
        XCTAssertEqual(hqMaisCara?.highestPrice(), 580.0)
    }
    
    func testHQExpensiveFail() throws {
        // Given
        var arrayComic = [ComicData]()
        
        // When
        arrayComic.append(Seed.ComicSeed.b)
        arrayComic.append(Seed.ComicSeed.c)
        
        let hqMaisCara = arrayComic.sorted().first
        
        // Then
        XCTAssertNotEqual(hqMaisCara?.highestPrice(), 450.0)
    }
    
    // MARK: Test CRUD

    func testAddComicToCoreData() {
        // Given
        let comic = Seed.ComicSeed.a
        
        // When
        comicWorker.create(obj: comic)
        
        // Then
        let row = comicWorker.fetchedResultsController.fetchedObjects!.count
        let newComic = comicWorker.read(at: IndexPath(row: row - 1, section: 0))
        
        XCTAssertEqual(comic.title, newComic.title, "The function should add and then be equal to the last comic added")
    }
    
    func testReadComicFromCoreData() {
        // Given
        let comic = Seed.ComicSeed.b
        
        // When
        let row = comicWorker.fetchedResultsController.fetchedObjects!.count
        let lastComic = comicWorker.read(at: IndexPath(row: row - 1, section: 0))
        
        // Then
        XCTAssertEqual(comic.title, lastComic.title, "The function should read the last comic added and then be the same as ComicData title")
    }
    
    func testUpdateComicFromCoreData() {
        // Given
        let row = comicWorker.fetchedResultsController.fetchedObjects!.count
        let comic = comicWorker.read(at: IndexPath(row: row - 1, section: 0))
        
        // When
        comic.setValue("Title test", forKey: "title")
        comicWorker.update(obj: comic)
        
        // Then
        XCTAssertEqual(comic.title, "Title test", "The function should update last comic added")
    }
    
    func testDeleteComicFromCoreData() {
        // Given
        let row = comicWorker.fetchedResultsController.fetchedObjects!.count
        let indexPath = IndexPath(row: row - 1, section: 0)
        
        // When
        XCTAssertNoThrow(comicWorker.delete(at: indexPath), "The function should delete last comic added")
        
        // Then
    }
    
    func testCountCharacterFromCoreData() {
        // Give
        var numComic = 0
        
        // When
        numComic = comicWorker.count()
        
        // Then
        XCTAssertTrue(numComic == 1)
    }

}
