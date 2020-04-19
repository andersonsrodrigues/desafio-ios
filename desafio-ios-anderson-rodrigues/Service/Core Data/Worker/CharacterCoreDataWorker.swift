//
//  CharacterCoreDataWorker.swift
//  desafio-ios-anderson-rodrigues
//
//  Created by Anderson Rodrigues on 15/04/2020.
//  Copyright © 2020 Anderson Rodrigues. All rights reserved.
//

import Foundation
import CoreData

// MARK: - Character Core Data Delegate
@objc protocol CharacterCoreDataWorkerDelegate {
    // MARK: Character update lifecycle
    @objc optional func characterCoreDataWorkerWillUpdate(characterCoreDataWorker: CharacterCoreDataWorker)
    @objc optional func characterCoreDataWorkerDidUpdate(characterCoreDataWorker: CharacterCoreDataWorker)
    
    // MARK: Character section updates
    @objc optional func characterCoreDataWorker(characterCoreDataWorker: CharacterCoreDataWorker, shouldInsertSection section: IndexSet)
    @objc optional func characterCoreDataWorker(characterCoreDataWorker: CharacterCoreDataWorker, shouldDeleteSection section: IndexSet)
    @objc optional func characterCoreDataWorker(characterCoreDataWorker: CharacterCoreDataWorker, shouldUpdateSection section: IndexSet)
    @objc optional func characterCoreDataWorker(characterCoreDataWorker: CharacterCoreDataWorker, shouldMoveSectionFrom from: IndexSet, to: IndexSet)
    
    // MARK: Character row updates
    @objc optional func characterCoreDataWorker(characterCoreDataWorker: CharacterCoreDataWorker, shouldInsertRowAt indexPath: IndexPath)
    @objc optional func characterCoreDataWorker(characterCoreDataWorker: CharacterCoreDataWorker, shouldDeleteRowAt indexPath: IndexPath)
    @objc optional func characterCoreDataWorker(characterCoreDataWorker: CharacterCoreDataWorker, shouldUpdateRowAt indexPath: IndexPath, withCharacter character: CharacterMarvel)
    @objc optional func characterCoreDataWorker(characterCoreDataWorker: CharacterCoreDataWorker, shouldMoveRowFrom from: IndexPath, to: IndexPath, withCharacter character: CharacterMarvel)
}

final class CharacterCoreDataWorker: NSObject, DataWorkerProtocol {
    
    // MARK: DataWorkerProtocol Protocol Types
    typealias ManagedObject = CharacterMarvel
    typealias Decoder = CharacterData
    
    var delegates = [CharacterCoreDataWorkerDelegate]()
    let viewContext = DataController.shared.viewContext
    
    // MARK: - Object lifecycle
    
    static let shared = CharacterCoreDataWorker()
    private override init() {
        super.init()
        
        self.setupFetchedResultsController(offset: 0)
    }
    
    // MARK: - Core Data stack
    
    var fetchedResultsController: NSFetchedResultsController<CharacterMarvel>!
    
    func setupFetchedResultsController(offset: Int) {
        let fetchRequest: NSFetchRequest<CharacterMarvel> = CharacterMarvel.fetchRequest()
        
        fetchRequest.fetchLimit = 20
        fetchRequest.fetchOffset = offset
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    // MARK: - Validation
    
    func validate(character: CharacterMarvel) -> Bool {
        return true
    }
    
    // MARK: - CRUD operations
    
    func create(obj: Decoder) {
        let characterModel = CharacterMarvel(context: viewContext)
        characterModel.id = Int32(exactly: NSNumber(value: obj.id ?? 0)) ?? 0
        characterModel.name = obj.name
        characterModel.desc = obj.description
        characterModel.thumbnailURL = obj.thumbnail?.path
        characterModel.thumbnailExt = obj.thumbnail?.extension
        
        guard validate(character: characterModel) else { return }
        
        try? viewContext.save()
    }
    
    func read(at indexPath: IndexPath) -> ManagedObject {
        return fetchedResultsController.object(at: indexPath)
    }
    
    func update(obj: ManagedObject) {
        guard validate(character: obj) else { return }
        try? viewContext.save()
    }
    
    func delete(at indexPath: IndexPath) {
        let comicModel = read(at: indexPath)
        viewContext.delete(comicModel)
        try? viewContext.save()
    }
    
    // MARK: CRUD operations extra
    func list() -> [ManagedObject] {
        do {
            try fetchedResultsController.performFetch()
            return fetchedResultsController.fetchedObjects!.map { $0 }
        } catch {
            fatalError("Unresolved error \(error), \(error.localizedDescription)")
        }
    }
    
    func erase() {
        for obj in fetchedResultsController.fetchedObjects! {
            viewContext.delete(obj)
        }
        
        try? viewContext.save()
    }
    
    // MARK: - Count
    
    func count() -> Int {
        return fetchedResultsController.sections![0].numberOfObjects
    }
    
}

// MARK: - NSFetchedResultsControllerDelegate
extension CharacterCoreDataWorker: NSFetchedResultsControllerDelegate {
  
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegates.forEach { $0.characterCoreDataWorkerWillUpdate?(characterCoreDataWorker: self) }
    }
  
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            delegates.forEach { $0.characterCoreDataWorker?(characterCoreDataWorker: self, shouldInsertSection: IndexSet(integer: sectionIndex)) }
        case .delete:
            delegates.forEach { $0.characterCoreDataWorker?(characterCoreDataWorker: self, shouldDeleteSection: IndexSet(integer: sectionIndex)) }
        default:
            return
        }
    }
  
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            delegates.forEach { $0.characterCoreDataWorker?(characterCoreDataWorker: self, shouldInsertRowAt: newIndexPath!) }
        case .delete:
            delegates.forEach { $0.characterCoreDataWorker?(characterCoreDataWorker: self, shouldDeleteRowAt: indexPath!) }
        case .update:
            let character = anObject as! CharacterMarvel
            delegates.forEach { $0.characterCoreDataWorker?(characterCoreDataWorker: self, shouldUpdateRowAt: indexPath!, withCharacter: character) }
        case .move:
            let character = anObject as! CharacterMarvel
            delegates.forEach { $0.characterCoreDataWorker?(characterCoreDataWorker: self, shouldMoveRowFrom: indexPath!, to: newIndexPath!, withCharacter: character) }
        default:
            return
        }
    }
  
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegates.forEach { $0.characterCoreDataWorkerDidUpdate?(characterCoreDataWorker: self) }
    }
}
