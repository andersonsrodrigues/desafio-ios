//
//  DataWorkerProtocol.swift
//  desafio-ios-anderson-rodrigues
//
//  Created by Anderson Rodrigues on 15/04/2020.
//  Copyright © 2020 Anderson Rodrigues. All rights reserved.
//

import Foundation

// MARK: - Data Methods
protocol DataWorkerProtocol {
    associatedtype ManagedObject
    associatedtype Decoder
    
    // MARK: CRUD operations
    
    func create(obj: Decoder)
    func read(at indexPath: IndexPath) -> ManagedObject
    func update(obj: ManagedObject)
    func delete(at indexPath: IndexPath)
    
    // MARK: CRUD operations extra
    func list() -> [ManagedObject]
    func erase()
    
    // MARK: Count
    func count() -> Int
}
