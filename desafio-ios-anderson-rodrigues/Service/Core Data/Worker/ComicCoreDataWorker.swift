//
//  ComicCoreDataWorker.swift
//  desafio-ios-anderson-rodrigues
//
//  Created by Anderson Rodrigues on 15/04/2020.
//  Copyright © 2020 Anderson Rodrigues. All rights reserved.
//

import Foundation
import CoreData

// MARK: - Comic Core Data Delegate
@objc protocol ComicCoreDataWorkerDelegate {
    // MARK: Comic update lifecycle
    @objc optional func comicCoreDataWorkerWillUpdate(comicCoreDataWorker: ComicCoreDataWorker)
    @objc optional func comicCoreDataWorkerDidUpdate(comicCoreDataWorker: ComicCoreDataWorker)
    
    // MARK: Comic section updates
    @objc optional func comicCoreDataWorker(comicCoreDataWorker: ComicCoreDataWorker, shouldInsertSection section: IndexSet)
    @objc optional func comicCoreDataWorker(comicCoreDataWorker: ComicCoreDataWorker, shouldDeleteSection section: IndexSet)
    @objc optional func comicCoreDataWorker(comicCoreDataWorker: ComicCoreDataWorker, shouldUpdateSection section: IndexSet)
    @objc optional func comicCoreDataWorker(comicCoreDataWorker: ComicCoreDataWorker, shouldMoveSectionFrom from: IndexSet, to: IndexSet)
    
    // MARK: Comic row updates
    @objc optional func comicCoreDataWorker(comicCoreDataWorker: ComicCoreDataWorker, shouldInsertRowAt indexPath: IndexPath)
    @objc optional func comicCoreDataWorker(comicCoreDataWorker: ComicCoreDataWorker, shouldDeleteRowAt indexPath: IndexPath)
    @objc optional func comicCoreDataWorker(comicCoreDataWorker: ComicCoreDataWorker, shouldUpdateRowAt indexPath: IndexPath, withComic comic: ComicMarvel)
    @objc optional func comicCoreDataWorker(comicCoreDataWorker: ComicCoreDataWorker, shouldMoveRowFrom from: IndexPath, to: IndexPath, withComic comic: ComicMarvel)
}

final class ComicCoreDataWorker: NSObject, DataWorkerProtocol {
    
    // MARK: DataWorkerProtocol Protocol Types
    typealias ManagedObject = ComicMarvel
    typealias Decoder = ComicData
    
    var delegates = [ComicCoreDataWorkerDelegate]()
    let viewContext = DataController.shared.viewContext
    var parentManagedObject: CharacterMarvel?
    
    // MARK: - Object lifecycle
    
    static let shared = ComicCoreDataWorker()
    private override init() {}
    
    // MARK: - Core Data stack
    
    var fetchedResultsController: NSFetchedResultsController<ComicMarvel>!
    
    func setupFetchedResultsController(character: CharacterMarvel) {
        let fetchRequest: NSFetchRequest<ComicMarvel> = ComicMarvel.fetchRequest()
        
        let predicate = NSPredicate(format: "character == %@", character)
        fetchRequest.predicate = predicate
        
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        parentManagedObject = character
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    // MARK: - Validation
    
    func validate(comic: ComicMarvel) -> Bool {
        return true
    }
    
    // MARK: - CRUD operations
    
    func create(obj: Decoder) {
        let comicModel = ComicMarvel(context: viewContext)
        comicModel.id = Int32(exactly: NSNumber(value: obj.id ?? 0)) ?? 0
        comicModel.title = obj.title
        comicModel.desc = obj.description
        comicModel.price = obj.highestPrice()
        comicModel.thumbnailURL = obj.thumbnail?.path
        comicModel.thumbnailExt = obj.thumbnail?.extension
        
        if let parent = parentManagedObject {
            comicModel.character = parent
        }
        
        guard validate(comic: comicModel) else { return }
        
        try? viewContext.save()
    }
    
    func read(at indexPath: IndexPath) -> ManagedObject {
        return fetchedResultsController.object(at: indexPath)
    }
    
    func update(obj: ManagedObject) {
        guard validate(comic: obj) else { return }
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
extension ComicCoreDataWorker: NSFetchedResultsControllerDelegate {
  
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegates.forEach { $0.comicCoreDataWorkerWillUpdate?(comicCoreDataWorker: self) }
    }
  
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            delegates.forEach { $0.comicCoreDataWorker?(comicCoreDataWorker: self, shouldInsertSection: IndexSet(integer: sectionIndex)) }
        case .delete:
            delegates.forEach { $0.comicCoreDataWorker?(comicCoreDataWorker: self, shouldDeleteSection: IndexSet(integer: sectionIndex)) }
        default:
            return
        }
    }
  
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            delegates.forEach { $0.comicCoreDataWorker?(comicCoreDataWorker: self, shouldInsertRowAt: newIndexPath!) }
        case .delete:
            delegates.forEach { $0.comicCoreDataWorker?(comicCoreDataWorker: self, shouldDeleteRowAt: indexPath!) }
        case .update:
            let comic = anObject as! ComicMarvel
            delegates.forEach { $0.comicCoreDataWorker?(comicCoreDataWorker: self, shouldUpdateRowAt: indexPath!, withComic: comic) }
        case .move:
            let comic = anObject as! ComicMarvel
            delegates.forEach { $0.comicCoreDataWorker?(comicCoreDataWorker: self, shouldMoveRowFrom: indexPath!, to: newIndexPath!, withComic: comic) }
        default:
            return
        }
    }
  
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegates.forEach { $0.comicCoreDataWorkerDidUpdate?(comicCoreDataWorker: self) }
    }
}
