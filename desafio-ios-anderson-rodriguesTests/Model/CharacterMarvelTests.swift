//
//  CharacterMarvelTests.swift
//  desafio-ios-anderson-rodriguesTests
//
//  Created by Anderson Rodrigues on 16/04/2020.
//  Copyright © 2020 Anderson Rodrigues. All rights reserved.
//

@testable import desafio_ios_anderson_rodrigues
import XCTest

class CharacterMarvelTests: XCTestCase {
    
    var characterData: CharacterData!
    var characterWorker: CharacterCoreDataWorker!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        
        setupCharacterData()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test Setup
    
    func setupCharacterData() {
        characterWorker = CharacterListModel.characterWorker
        
        let character = Seed.CharacterSeed.b
        characterWorker.create(obj: character)
    }
    
    func testJSONParseToComic() throws {
        let json = Seed.CharacterJSON.data
        let decoder = JSONDecoder()
        do {
            let character: CharacterData = try decoder.decode(CharacterData.self, from: json)

            XCTAssertEqual(character.id, 1010996)
            XCTAssertEqual(character.name, "Yellowjacket (Rita DeMara)")
        } catch {
            print(error)
        }
    }
    
    // MARK: Test CRUD

    func testAddCharacterToCoreData() {
        // Given
        let character = Seed.CharacterSeed.b
        
        // When
        characterWorker.create(obj: character)
        
        // Then
        let row = characterWorker.fetchedResultsController.fetchedObjects!.count
        let newCharacter = characterWorker.read(at: IndexPath(row: row - 1, section: 0))
        
        XCTAssertEqual(character.name, newCharacter.name, "The function should add and then be equal to the last character added")
    }
    
    func testReadCharacterFromCoreData() {
        // Given
        let character = Seed.CharacterSeed.b
        
        // When
        let row = characterWorker.fetchedResultsController.fetchedObjects!.count
        let lastCharacter = characterWorker.read(at: IndexPath(row: row - 1, section: 0))
        
        // Then
        XCTAssertEqual(character.name, lastCharacter.name, "The function should read the last character added and then be the same as CharacterData name")
    }
    
    func testUpdateCharacterFromCoreData() {
        // Given
        let row = characterWorker.fetchedResultsController.fetchedObjects!.count
        let character = characterWorker.read(at: IndexPath(row: row - 1, section: 0))
        
        // When
        character.setValue("Name test", forKey: "name")
        characterWorker.update(obj: character)
        
        // Then
        XCTAssertEqual(character.name, "Name test", "The function should update last character added")
    }
    
    func testDeleteCharacterFromCoreData() {
        // Given
        let row = characterWorker.fetchedResultsController.fetchedObjects!.count
        let indexPath = IndexPath(row: row - 1, section: 0)
        
        // When
        XCTAssertNoThrow(characterWorker.delete(at: indexPath), "The function should delete last character added")
        
        // Then
    }
    
    func testCountCharacterFromCoreData() {
        // Give
        var numCharacter = 0
        
        // When
        numCharacter = characterWorker.count()
        
        // Then
        XCTAssertTrue(numCharacter > 0)
    }
}
