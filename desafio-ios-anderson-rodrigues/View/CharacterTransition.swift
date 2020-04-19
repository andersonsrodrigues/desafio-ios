//
//  CharacterTransition.swift
//  desafio-ios-anderson-rodrigues
//
//  Created by Anderson Rodrigues on 17/04/2020.
//  Copyright © 2020 Anderson Rodrigues. All rights reserved.
//

import UIKit

class CharacterTransition: NSObject, UINavigationControllerDelegate {
    
    fileprivate var currentAnimationTransition: UIViewControllerAnimatedTransitioning? = nil

    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let result: UIViewControllerAnimatedTransitioning?
        
        if let characterDetailVC = toVC as? CharacterDetailViewController, let characterDelegate = fromVC as? CharacterDetailTransitionAnimatorDelegate, operation == .push {
            result = CharacterPushAnimator(fromDelegate: characterDelegate, toCharacterDetailVC: characterDetailVC)
        } else if let characterDetailVC = fromVC as? CharacterDetailViewController, let characterDelegate = toVC as? CharacterDetailTransitionAnimatorDelegate, operation == .pop {
            result = CharacterPopAnimator(toDelegate: characterDelegate, fromCharacterDetailVC: characterDetailVC )
        } else {
            result = nil
        }
        
        currentAnimationTransition = result
        return result
    }
    
    public func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return currentAnimationTransition as? UIViewControllerInteractiveTransitioning
    }
}
