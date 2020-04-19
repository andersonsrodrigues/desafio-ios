//
//  CharacterListRouter.swift
//  desafio-ios-anderson-rodrigues
//
//  Created by Anderson Rodrigues on 15/04/2020.
//  Copyright (c) 2020 Anderson Rodrigues. All rights reserved.
//

import UIKit

@objc protocol CharacterListRoutingLogic {
	func routeToCharacterDetailSegue(segue: UIStoryboardSegue?)
}

protocol CharacterListDataPassing {
	var dataStore: CharacterListDataStore? { get }
}

class CharacterListRouter: NSObject, CharacterListRoutingLogic, CharacterListDataPassing {
	weak var viewController: CharacterListViewController?
	var dataStore: CharacterListDataStore?
	
	// MARK: Routing
	
	func routeToCharacterDetailSegue(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! CharacterDetailViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToCharacterDetail(source: dataStore!, destination: &destinationDS)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "CharacterDetailViewController") as! CharacterDetailViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToCharacterDetail(source: dataStore!, destination: &destinationDS)
            navigateToSomewhere(source: viewController!, destination: destinationVC)
        }
	}

	// MARK: Navigation
	
	func navigateToSomewhere(source: CharacterListViewController, destination: CharacterDetailViewController) {
        source.show(destination, sender: nil)
	}
	
	// MARK: Passing data
	
	func passDataToCharacterDetail(source: CharacterListDataStore, destination: inout CharacterDetailDataStore) {
        destination.character = source.character
	}
}
