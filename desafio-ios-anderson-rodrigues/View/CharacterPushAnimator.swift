//
//  CharacterPushAnimator.swift
//  desafio-ios-anderson-rodrigues
//
//  Created by Anderson Rodrigues on 17/04/2020.
//  Copyright © 2020 Anderson Rodrigues. All rights reserved.
//

import UIKit

class CharacterPushAnimator: NSObject {
    
    let duration = 0.8
    
    private let fromDelegate: CharacterDetailTransitionAnimatorDelegate
    private let characterDetailVC: CharacterDetailViewController
    
    private let transitionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    init(fromDelegate: CharacterDetailTransitionAnimatorDelegate, toCharacterDetailVC characterDetailVC: CharacterDetailViewController ) {
        self.fromDelegate = fromDelegate
        self.characterDetailVC = characterDetailVC
    }
}
 
extension CharacterPushAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        let characterFromView = transitionContext.view(forKey: .from)
        let characterToView = transitionContext.view(forKey: .to)
        
        [characterFromView, characterToView]
            .compactMap { $0 }
            .forEach {
                containerView.addSubview($0)
        }
        
        let transitionImage = fromDelegate.referenceImageView()
        transitionImageView.image = transitionImage.image
        transitionImageView.frame = fromDelegate.imageFrame()!
        transitionImageView.layer.cornerRadius = 8.0
        
        containerView.addSubview(self.transitionImageView)

        fromDelegate.transitionWillStart()
        characterDetailVC.transitionWillStart()
        
        UIView.animate(withDuration: duration, animations: {
            self.transitionImageView.frame = self.characterDetailVC.imageFrame()!
        }) { (_) in
            self.transitionImageView.removeFromSuperview()
            self.transitionImageView.image = nil
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            
            self.characterDetailVC.transitionDidEnd()
            self.fromDelegate.transitionDidEnd()
        }

    }
}
