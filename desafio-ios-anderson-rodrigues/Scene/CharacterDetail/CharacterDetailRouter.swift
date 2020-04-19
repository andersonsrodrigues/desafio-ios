//
//  CharacterDetailRouter.swift
//  desafio-ios-anderson-rodrigues
//
//  Created by Anderson Rodrigues on 16/04/2020.
//  Copyright (c) 2020 Anderson Rodrigues. All rights reserved.
//

import UIKit

@objc protocol CharacterDetailRoutingLogic {
	func routeToComicDetailSegue(segue: UIStoryboardSegue?)
}

protocol CharacterDetailDataPassing {
	var dataStore: CharacterDetailDataStore? { get }
}

class CharacterDetailRouter: NSObject, CharacterDetailRoutingLogic, CharacterDetailDataPassing {
	weak var viewController: CharacterDetailViewController?
	var dataStore: CharacterDetailDataStore?
	
	// MARK: Routing
	
	func routeToComicDetailSegue(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! ComicDetailViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToComicDetailView(source: dataStore!, destination: &destinationDS)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "ComicDetailViewController") as! ComicDetailViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToComicDetailView(source: dataStore!, destination: &destinationDS)
            navigateToComicDetailView(source: viewController!, destination: destinationVC)
        }
	}

    // MARK: Navigation
	
	func navigateToComicDetailView(source: CharacterDetailViewController, destination: ComicDetailViewController) {
        source.show(destination, sender: nil)
	}
	
    // MARK: Passing data
	
	func passDataToComicDetailView(source: CharacterDetailDataStore, destination: inout ComicDetailDataStore) {
        destination.character = source.character
	}
}
