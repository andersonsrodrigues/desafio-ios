//
//  CharacterDetailViewController.swift
//  desafio-ios-anderson-rodrigues
//
//  Created by Anderson Rodrigues on 16/04/2020.
//  Copyright (c) 2020 Anderson Rodrigues. All rights reserved.
//

import UIKit

private let segueComicDetail = "ComicDetailSegue"

// MARK: - Protocol
protocol CharacterDetailDisplayLogic: class {
    // MARK: Display Methods
	func displayCharacterDetail(viewModel: CharacterDetailModel.Character.ViewModel)
    
    // MARK: Perform Segue To Details
    func displayComicDetailsView(viewModel: CharacterDetailModel.ComicDetail.ViewModel)
}

class CharacterDetailViewController: UIViewController, CharacterDetailDisplayLogic {
	var interactor: CharacterDetailBusinessLogic?
	var router: (NSObjectProtocol & CharacterDetailRoutingLogic & CharacterDetailDataPassing)?
    
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
		let interactor = CharacterDetailInteractor()
		let presenter = CharacterDetailPresenter()
		let router = CharacterDetailRouter()
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
	
	// MARK: - View lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        }
        
        loadingView = LoadingView(view: view)
	}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupDetailsView()
        setDarkMode()
        
        requestCharacterDetail()
    }
	
	// MARK: Character Detail
	
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var characterTitleLabel: UILabel!
    @IBOutlet weak var characterDescTitle: UILabel!
    @IBOutlet weak var characterDescLabel: UILabel!
    @IBOutlet weak var comicHQButton: UIButton!
	
    // MARK: Setup
    
	func requestCharacterDetail() {
        loadingView?.showActivityView()
        
		let request = CharacterDetailModel.Character.Request()
		interactor?.requestCharacteDetail(request: request)
	}
	
	func displayCharacterDetail(viewModel: CharacterDetailModel.Character.ViewModel) {
        loadingView?.hideActivityView()
        
        let character = viewModel.character
        
        if let data = character.thumbnail {
            let image = UIImage(data: data)
            thumbnailImageView.image = image
        } else {
            let image = UIImage(named: "image-background")
            thumbnailImageView.image = image
        }
        
        characterTitleLabel.text = character.name ?? "No name"
        
        if let desc = character.desc {
            characterDescLabel.text = desc != "" ? desc : "No information"
        } else {
            characterDescLabel.text = "No information"
        }
	}
    
    func setupDetailsView() {
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.layer.cornerRadius = 8.0
        
        characterTitleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        characterTitleLabel.font = .systemFont(ofSize: 28.0, weight: .bold)
        characterTitleLabel.numberOfLines = 3
        
        characterDescTitle.text = "Summary"
        characterDescTitle.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        characterDescTitle.font = .systemFont(ofSize: 24.0, weight: .bold)
        
        characterDescLabel.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        characterDescLabel.font = .systemFont(ofSize: 15.0, weight: .medium)
        characterDescLabel.numberOfLines = 3
        
        comicHQButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        comicHQButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        comicHQButton.layer.cornerRadius = 8.0
        
        comicHQButton.addTarget(self, action: #selector(requestComicDescView(sender:)), for: .touchUpInside)
    }
    
    // MARK: Perform Segue To Comic
    
    @IBAction func requestComicDescView(sender: UIButton) {
        let request = CharacterDetailModel.ComicDetail.Request()
        interactor?.provideDataStoreToComicDetail(request: request)
    }
    
    func displayComicDetailsView(viewModel: CharacterDetailModel.ComicDetail.ViewModel) {
        performSegue(withIdentifier: segueComicDetail, sender: self)
    }
    
    // MARK: - View Animation Method
    func initThumbnailImageFrame() -> CGRect{
        var y = thumbnailImageView.frame.origin.y

        if let navY = navigationController?.navigationBar.frame.origin.y, let navHeight = navigationController?.navigationBar.frame.height {
            y = navY + (thumbnailImageView.frame.origin.y - navHeight)
        }
        
        let width = view.frame.width - (thumbnailImageView.frame.origin.x + (thumbnailImageView.frame.maxX - thumbnailImageView.frame.width))
        return CGRect(x: thumbnailImageView.frame.origin.x, y: y, width: width, height: thumbnailImageView.frame.height)
    }
}

extension CharacterDetailViewController: CharacterDetailTransitionAnimatorDelegate {
    func transitionWillStart() {
        thumbnailImageView.isHidden = true
    }

    func transitionDidEnd() {
        thumbnailImageView.isHidden = false
    }

    func referenceImageView() -> UIImageView {
        return thumbnailImageView
    }

    func imageFrame() -> CGRect? {
        return initThumbnailImageFrame()
    }
}
