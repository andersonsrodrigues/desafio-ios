//
//  ComicDetailRouter.swift
//  desafio-ios-anderson-rodrigues
//
//  Created by Anderson Rodrigues on 16/04/2020.
//  Copyright (c) 2020 Anderson Rodrigues. All rights reserved.
//

import UIKit

@objc protocol ComicDetailRoutingLogic {
	//func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol ComicDetailDataPassing {
	var dataStore: ComicDetailDataStore? { get }
}

class ComicDetailRouter: NSObject, ComicDetailRoutingLogic, ComicDetailDataPassing {
	weak var viewController: ComicDetailViewController?
	var dataStore: ComicDetailDataStore?
	
	// MARK: Routing
	
	//func routeToSomewhere(segue: UIStoryboardSegue?) {
	//  if let segue = segue {
	//    let destinationVC = segue.destination as! SomewhereViewController
	//    var destinationDS = destinationVC.router!.dataStore!
	//    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
	//  } else {
	//    let storyboard = UIStoryboard(name: "Main", bundle: nil)
	//    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
	//    var destinationDS = destinationVC.router!.dataStore!
	//    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
	//    navigateToSomewhere(source: viewController!, destination: destinationVC)
	//  }
	//}

	// MARK: Navigation
	
	//func navigateToSomewhere(source: ComicDetailViewController, destination: SomewhereViewController) {
	//  source.show(destination, sender: nil)
	//}
	
	// MARK: Passing data
	
	//func passDataToSomewhere(source: ComicDetailDataStore, destination: inout SomewhereDataStore) {
	//  destination.name = source.name
	//}
}
