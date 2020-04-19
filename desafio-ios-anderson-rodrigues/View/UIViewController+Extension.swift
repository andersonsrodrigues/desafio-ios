//
//  UIViewController+Extension.swift
//  desafio-ios-anderson-rodrigues
//
//  Created by Anderson Rodrigues on 15/04/2020.
//  Copyright © 2020 Anderson Rodrigues. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlertFailure(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    private func initDarkModeView() {
        view.backgroundColor = #colorLiteral(red: 0.145080179, green: 0.1451074183, blue: 0.1450739205, alpha: 1)
        
        if let navigation = navigationController {
            
            navigation.navigationBar.barStyle = .black
            navigation.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
            navigation.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)
            
            // Make the navigation bar's title with red text.
            if #available(iOS 13.0, *) {
                let appearance = UINavigationBarAppearance()

                appearance.configureWithOpaqueBackground()
                appearance.backgroundColor = #colorLiteral(red: 0.145080179, green: 0.1451074183, blue: 0.1450739205, alpha: 1)
                appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
                appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
                navigationItem.standardAppearance = appearance
                navigationItem.scrollEdgeAppearance = appearance
                navigationItem.compactAppearance = appearance // For iPhone small navigation bar in landscape.

                navigation.navigationBar.isTranslucent = true
            } else {
                navigation.navigationBar.barTintColor = #colorLiteral(red: 0.145080179, green: 0.1451074183, blue: 0.1450739205, alpha: 1)
                navigation.navigationBar.isTranslucent = false
            }
        }
    }
    
    func setDarkMode() {
        initDarkModeView()
    }
    
    func setDarkMode(tableView: UITableView?) {
        setDarkMode()
        
        if let tableView = tableView {
            tableView.backgroundColor = #colorLiteral(red: 0.145080179, green: 0.1451074183, blue: 0.1450739205, alpha: 1)
        }
    }
    
    func setDarkMode(collectionView: UICollectionView?) {
        setDarkMode()

        if let collectionView = collectionView {
            collectionView.backgroundColor = #colorLiteral(red: 0.145080179, green: 0.1451074183, blue: 0.1450739205, alpha: 1)
        }
    }
}
