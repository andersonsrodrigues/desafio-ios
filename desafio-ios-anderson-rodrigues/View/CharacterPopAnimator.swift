//
//  CharacterPopAnimator.swift
//  desafio-ios-anderson-rodrigues
//
//  Created by Anderson Rodrigues on 17/04/2020.
//  Copyright © 2020 Anderson Rodrigues. All rights reserved.
//

import UIKit

class CharacterPopAnimator: NSObject {
    
    let duration = 0.8
    
    private let toDelegate: CharacterDetailTransitionAnimatorDelegate
    private let characterDetailVC: CharacterDetailViewController

    private lazy var transitionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    init(toDelegate: CharacterDetailTransitionAnimatorDelegate, fromCharacterDetailVC characterDetailVC: CharacterDetailViewController) {
        self.toDelegate = toDelegate
        self.characterDetailVC = characterDetailVC
    }
}

extension CharacterPopAnimator: UIViewControllerAnimatedTransitioning {
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        let characterFromView = transitionContext.view(forKey: .from)
        let characterToView = transitionContext.view(forKey: .to)
        
        [characterFromView, characterToView]
            .compactMap { $0 }
            .forEach {
                containerView.addSubview($0)
        }
        
        let transitionImage = characterDetailVC.referenceImageView()
        transitionImageView.image = transitionImage.image
        transitionImageView.frame = transitionImage.frame
        transitionImageView.layer.cornerRadius = 8.0

        containerView.addSubview(transitionImageView)

        characterDetailVC.transitionWillStart()
        toDelegate.transitionWillStart()
        
        UIView.animate(withDuration: duration, animations: {
            self.transitionImageView.frame = self.toDelegate.imageFrame()!
        }) { (_) in
            self.transitionImageView.removeFromSuperview()
            self.transitionImageView.image = nil
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            
            self.characterDetailVC.transitionDidEnd()
            self.toDelegate.transitionDidEnd()
        }
    }
}
