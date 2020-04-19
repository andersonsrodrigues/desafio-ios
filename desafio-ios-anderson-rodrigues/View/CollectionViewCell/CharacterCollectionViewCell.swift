//
//  CharacterCollectionViewCell.swift
//  desafio-ios-anderson-rodrigues
//
//  Created by Anderson Rodrigues on 16/04/2020.
//  Copyright © 2020 Anderson Rodrigues. All rights reserved.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var gradientView: UIView!
    
    private let gradientLayer: CAGradientLayer = CAGradientLayer()
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.style = UIActivityIndicatorView.Style.whiteLarge
        return indicator
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        setupGradient()
        setupCellLayout()
    }

    func setupGradient() {
        let colorTop = UIColor.clear.cgColor
        let colorBottom = #colorLiteral(red: 0.145080179, green: 0.1451074183, blue: 0.1450739205, alpha: 1)
        
        gradientLayer.frame = gradientView.bounds
        gradientLayer.colors = [colorTop, colorBottom.cgColor, colorBottom.cgColor]
        gradientLayer.locations = [0.0, 0.85, 1.0]
        gradientView.backgroundColor = .clear
        gradientView.layer.addSublayer(gradientLayer)
    }
    
    func showActivityIndicator() {
        activityIndicatorView.frame = layer.frame
        activityIndicatorView.center = thumbnailImageView.center
        activityIndicatorView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
        gradientView.addSubview(activityIndicatorView)
        gradientView.bringSubviewToFront(activityIndicatorView)
        
        activityIndicatorView.startAnimating()
    }
    
    func hideActivityIndicator() {
        activityIndicatorView.stopAnimating()
        activityIndicatorView.removeFromSuperview()
    }
    
    private func setupCellLayout() {
        clipsToBounds = true
        
        layer.cornerRadius = 8.0
        layer.backgroundColor = UIColor.clear.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        layer.shadowRadius = 3.0
        layer.shadowOpacity = 0.2
        layer.masksToBounds = false

        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 8.0
        contentView.layer.masksToBounds = true
        
        nameLabel.font = .systemFont(ofSize: 17.0, weight: .bold)
        nameLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        thumbnailImageView.contentMode = .scaleAspectFill
    }
}
