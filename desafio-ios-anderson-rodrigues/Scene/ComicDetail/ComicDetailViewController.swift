//
//  ComicDetailViewController.swift
//  desafio-ios-anderson-rodrigues
//
//  Created by Anderson Rodrigues on 16/04/2020.
//  Copyright (c) 2020 Anderson Rodrigues. All rights reserved.
//

import UIKit

// MARK: - Protocol
protocol ComicDetailDisplayLogic: class {
    // MARK: Display Comic
	func displayComicDetail(viewModel: ComicDetailModel.Comic.ViewModel)
    func displayComicThumbnail(viewModel: ComicDetailModel.CoverImage.ViewModel)
    
    // MARK: Error Display Comic
    func displayErrorComicDetail(viewModel: ComicDetailModel.Comic.ViewModel)
    func displayErrorComicThumbnail(viewModel: ComicDetailModel.CoverImage.ViewModel)
}

class ComicDetailViewController: UIViewController, ComicDetailDisplayLogic {
	var interactor: ComicDetailBusinessLogic?
	var router: (NSObjectProtocol & ComicDetailRoutingLogic & ComicDetailDataPassing)?
    
    var loadingView: LoadingView?

	// MARK: Object lifecycle
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		setup()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}
	
	// MARK: Setup
	
	private func setup() {
		let viewController = self
		let interactor = ComicDetailInteractor()
		let presenter = ComicDetailPresenter()
		let router = ComicDetailRouter()
		viewController.interactor = interactor
		viewController.router = router
		interactor.presenter = presenter
		presenter.viewController = viewController
		router.viewController = viewController
		router.dataStore = interactor
	}
	
	// MARK: Routing
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let scene = segue.identifier {
			let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
			if let router = router, router.responds(to: selector) {
				router.perform(selector, with: segue)
			}
		}
	}
	
	// MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingView = LoadingView(view: view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setDarkMode()
        setupComicView()
        setupNotFoundView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupGradient()
        requestComicDetail()
    }
	
	// MARK: Setup View
	
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var comicNameLabel: UILabel!
    @IBOutlet weak var comicPriceLabel: UILabel!
    @IBOutlet weak var comicDescTitleLabel: UILabel!
    @IBOutlet weak var comicDescLabel: UILabel!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var notFoundView: UIView!
    
    @IBOutlet weak var notFoundImage: UIImageView!
    @IBOutlet weak var notFoundLabel: UILabel!
    
    let gradientLayer: CAGradientLayer = CAGradientLayer()
    
    func setupComicView() {
        contentView.isHidden = true
        contentView.backgroundColor = .clear
        
        thumbnailImageView.contentMode = .scaleAspectFill
        
        comicNameLabel.text = ""
        comicNameLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        comicNameLabel.font = .systemFont(ofSize: 24.0, weight: .bold)
        comicNameLabel.numberOfLines = 3
        
        comicPriceLabel.text = ""
        comicPriceLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        comicPriceLabel.font = .systemFont(ofSize: 17.0, weight: .light)
        
        comicDescTitleLabel.text = "Summary"
        comicDescTitleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        comicDescTitleLabel.font = .systemFont(ofSize: 24.0, weight: .bold)
        
        comicDescLabel.text = ""
        comicDescLabel.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        comicDescLabel.font = .systemFont(ofSize: 15.0, weight: .medium)
        comicDescLabel.numberOfLines = 3
        
        closeButton.setTitle("", for: .normal)
        closeButton.setImage(UIImage(named: "close-button"), for: .normal)
        closeButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    func setupNotFoundView() {
        notFoundView.isHidden = true
        
        notFoundImage.image = UIImage(named: "error-image")
        notFoundImage.contentMode = .scaleAspectFill
        
        notFoundLabel.text = "The comic you requested was not found"
        notFoundLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        notFoundLabel.font = .systemFont(ofSize: 20.0, weight: .bold)
        notFoundLabel.textAlignment = .center
        notFoundLabel.numberOfLines = 3
    }
    
    func setupGradient() {
        let colorBody = UIColor.clear
        let colorBottom = #colorLiteral(red: 0.145080179, green: 0.1451074183, blue: 0.1450739205, alpha: 1)
        
        gradientLayer.frame = gradientView.frame
        gradientLayer.colors = [colorBody.cgColor, colorBottom.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        gradientView.layer.addSublayer(gradientLayer)
        gradientView.bringSubviewToFront(closeButton)
    }
	
    // MARK: - Fetches & Displays
    
	func requestComicDetail() {
        loadingView?.showActivityView()
        
		let request = ComicDetailModel.Comic.Request()
		interactor?.requestComicDetail(request: request)
	}
	
    func displayComicDetail(viewModel: ComicDetailModel.Comic.ViewModel) {
        loadingView?.hideActivityView()
        
        if let comic = viewModel.comic {
            contentView.isHidden = false
            
            if let title = comic.title {
                comicNameLabel.text = title
            } else {
                comicNameLabel.text = "No title"
            }
            
            if let desc = comic.desc {
                comicDescLabel.text = desc
            } else {
                comicDescLabel.text = "No information"
            }
            
            comicPriceLabel.text = "$\(String(format: "%.2f", comic.price))"
            
            if let data = comic.thumbnail {
                let image = UIImage(data: data)
                thumbnailImageView.image = image
            } else if let url = comic.thumbnailURL, let ext = comic.thumbnailExt {
                requestComicThumbnail(url: url, ext: ext)
            }
        } else {
            notFoundView.isHidden = false
        }
    }
    
    func requestComicThumbnail(url: String, ext: String) {
        let request = ComicDetailModel.CoverImage.Request(url: url, size: .standardFantastic, ext: ext)
        interactor?.requestComicThumbnail(request: request)
    }
    
    func displayComicThumbnail(viewModel: ComicDetailModel.CoverImage.ViewModel) {
        loadingView?.hideActivityView()
        
        if let image = viewModel.displayedImage {
            thumbnailImageView.image = image.cover
        } else {
            thumbnailImageView.image = UIImage(named: "image-background")
        }
    }
    
    // MARK: Error Display Methods
    
    func displayErrorComicDetail(viewModel: ComicDetailModel.Comic.ViewModel) {
        loadingView?.hideActivityView()
        notFoundView.isHidden = false
    }
    
    func displayErrorComicThumbnail(viewModel: ComicDetailModel.CoverImage.ViewModel) {
        loadingView?.hideActivityView()
        
        showAlertFailure(title: "Image", message: viewModel.error!)
    }
    
    // MARK: - Action
    
    @IBAction func closeView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
