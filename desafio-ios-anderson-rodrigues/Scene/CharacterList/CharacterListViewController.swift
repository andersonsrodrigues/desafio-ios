//
//  CharacterListViewController.swift
//  desafio-ios-anderson-rodrigues
//
//  Created by Anderson Rodrigues on 15/04/2020.
//  Copyright (c) 2020 Anderson Rodrigues. All rights reserved.
//

import UIKit

private let reuseTableViewCellIdentifier = "characterCellIdentifier"
private let reuseCollectionViewCellIdentifier = "characterCellIdentifier"
private let segueCharacterDetail = "CharacterDetailSegue"
private let cellCollectionIdentifier = "CharacterCollectionViewCell"

// MARK: - Protocol
protocol CharacterListDisplayLogic: class {
    // MARK: Display Methods
	func displayCharacterList(viewModel: CharacterListModel.Character.ViewModel)
    func displayCharacterThumbnail(viewModel: CharacterListModel.CoverImage.ViewModel)
    
    // MARK: Error Display Methods
    func displayErrorCharacterList(viewModel: CharacterListModel.Character.ViewModel)
    func displayErrorCharacterThumbnail(viewModel: CharacterListModel.CoverImage.ViewModel)
    
    // MARK: Category row updates
    func displayInsertedRow(at: IndexPath)
    func displayDeletedRow(at: IndexPath)
    func displayUpdatedRow(at: IndexPath, withDisplayedCharacter displayedCharacter: CharacterListModel.DisplayedCell)
    func displayMovedRow(from: IndexPath, to: IndexPath, withDisplayedCharacter displayedCharacter: CharacterListModel.DisplayedCell)
    
    // MARK: CRUD operations
    func displayFetchedCharacterRowAndConfigureCell(viewModel: CharacterListModel.FetchCharacterRowAndConfigureCell.ViewModel)
    
    // MARK: Perform Segue To Details
    func displayCharacterDetailsView(viewModel: CharacterListModel.CharacterDetail.ViewModel)
    
    // MARK: Pages
    func displayPageInfo(viewModel: CharacterListModel.CharacterPage.ViewModel)
}

class CharacterListViewController: UIViewController, CharacterListDisplayLogic {
    
	var interactor: CharacterListBusinessLogic?
	var router: (NSObjectProtocol & CharacterListRoutingLogic & CharacterListDataPassing)?
    
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
		let interactor = CharacterListInteractor()
		let presenter = CharacterListPresenter()
		let router = CharacterListRouter()
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
    
    // MARK: - Animations
    
    let transition = CharacterTransition()
	
	// MARK: - View lifecycle
    
    var currentPage: Int = 1
    var offsetPage: Int = 0
    var totalPage: Int = 0
    
	override func viewDidLoad() {
		super.viewDidLoad()
		
        loadingView = LoadingView(view: view)
        requestPagesInfo()
        
        navigationController?.delegate = transition
	}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "Marvel"
        
        setDarkMode(collectionView: collectionView)
        setupPaginationToolbar()
        initCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        requestCharacterList()
    }
	
	// MARK: Display Methods
    
    func requestCharacterList() {
        loadingView?.showActivityView()
        
        let page = CharacterListModel.Page(current: currentPage, offset: offsetPage, total: totalPage)
        let request = CharacterListModel.Character.Request(page: page)
        interactor?.requestCharacterList(request: request)
    }
    
    func requestRefreshCharacterList() {
        loadingView?.showActivityView()
        
        let page = CharacterListModel.Page(current: currentPage, offset: offsetPage, total: totalPage)
        let request = CharacterListModel.Character.Request(page: page)
        interactor?.requestRefreshCharacterList(request: request)
    }
    
    func displayCharacterList(viewModel: CharacterListModel.Character.ViewModel) {
        loadingView?.hideActivityView()
        
        offsetPage = viewModel.page.offset
        totalPage = viewModel.page.total
        
        checkPageButtonsStatus()
        collectionView.reloadData()
    }
    
    func displayCharacterThumbnail(viewModel: CharacterListModel.CoverImage.ViewModel) {
        let cell = viewModel.cell
        cell.hideActivityIndicator()
        
        if let image = viewModel.displayedImage {
            cell.thumbnailImageView.image = image.cover
        } else {
            cell.thumbnailImageView.image = UIImage(named: "image-background")
        }
    }
    
    // MARK: Character Row & Configure Cell
    
    func fetchCharacterRowAndConfigure(_ cell: CharacterCollectionViewCell, at indexPath: IndexPath) {
        let request = CharacterListModel.FetchCharacterRowAndConfigureCell.Request(indexPath: indexPath, cell: cell)
        interactor?.fetchCharacterRow(request: request)
    }
    
    func displayFetchedCharacterRowAndConfigureCell(viewModel: CharacterListModel.FetchCharacterRowAndConfigureCell.ViewModel) {
        configureCell(viewModel.cell!, withDisplayedCell: viewModel.displayedCharacter, at: viewModel.indexPath)
    }
    
    // MARK: Error Display Methods
    
    func displayErrorCharacterList(viewModel: CharacterListModel.Character.ViewModel) {
        loadingView?.hideActivityView()
        
        showAlertFailure(title: "Characters", message: viewModel.error!)
    }
    
    func displayErrorCharacterThumbnail(viewModel: CharacterListModel.CoverImage.ViewModel) {
        loadingView?.hideActivityView()
        
        showAlertFailure(title: "Image", message: viewModel.error!)
    }
    
    // MARK: Display
    
    func displayCharacterDetailsView(viewModel: CharacterListModel.CharacterDetail.ViewModel) {
        performSegue(withIdentifier: segueCharacterDetail, sender: self)
    }
    
    // MARK: Pages
    
    func requestPagesInfo() {
        let request = CharacterListModel.CharacterPage.Request()
        interactor?.requestPageInfo(request: request)
    }
    
    func displayPageInfo(viewModel: CharacterListModel.CharacterPage.ViewModel) {
        currentPage = viewModel.current
        offsetPage = viewModel.offset
        totalPage = viewModel.total
    }
    
    // MARK: - UICollectionView
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var collectionViewCellSelected: UICollectionViewCell?
    
    func initCollectionView() {
        renderCollectionFlowLayout()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        registerCells()
        configureRefreshControl()
    }
    
    func registerCells() {
        let nib = UINib(nibName: cellCollectionIdentifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: reuseCollectionViewCellIdentifier)
    }
    
    func configureRefreshControl () {
       collectionView.refreshControl = UIRefreshControl()
       collectionView.refreshControl?.addTarget(self, action:
                                          #selector(handleRefreshControl),
                                          for: .valueChanged)
    }
        
    @objc func handleRefreshControl() {
        requestRefreshCharacterList()

        DispatchQueue.main.async {
            self.collectionView.refreshControl?.endRefreshing()
        }
    }
    
    // MARK: Flow Layout
    
    func renderCollectionFlowLayout() {
        let space:CGFloat = 16.0
        let flowLayout = UICollectionViewFlowLayout()
        let dimensionWidth = calcDimensionCollectionCellWidth(space)
        let dimensionHeight = calcDimensionCollectionCellHeight(space)
        
        flowLayout.itemSize = CGSize(width: dimensionWidth, height: dimensionHeight)
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.sectionInset = UIEdgeInsets(top: space, left: space, bottom: space, right: space)
        
        collectionView.collectionViewLayout = flowLayout
    }
    
    func calcDimensionCollectionCellWidth(_ space: CGFloat) -> CGFloat {
        let width = view.frame.size.width
        
        return (width - (3 * space)) / 2.0
    }
    
    func calcDimensionCollectionCellHeight(_ space: CGFloat) -> CGFloat {
        let width = view.frame.size.width
        let height = view.frame.size.height
        
        var dimension = (width - (0.5 * space)) / 2.0
        
        if width > height {
            dimension = (height - (0.5 * space)) / 2.0
        }
        
        return dimension
    }
    
    // MARK: - UIToolbar
    
    @IBOutlet weak var paginationToolbar: UIToolbar!
    @IBOutlet weak var previousBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var currentBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var nextBarButtonItem: UIBarButtonItem!
    
    // MARK: Setup
    
    func setupPaginationToolbar() {
        paginationToolbar.barStyle = .black
        paginationToolbar.isTranslucent = true
        paginationToolbar.tintColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)
        
        currentBarButtonItem.isEnabled = false
        currentBarButtonItem.title = "Page \(currentPage)"
        
        previousBarButtonItem.image = UIImage(named: "previous-button")
        previousBarButtonItem.action = #selector(previousPage(sender:))
        
        nextBarButtonItem.image = UIImage(named: "next-button")
        nextBarButtonItem.action = #selector(nextPage(sender:))
        
        checkPageButtonsStatus()
    }
    
    func checkPageButtonsStatus() {
        currentBarButtonItem.title = "Page \(currentPage)"
        
        if offsetPage <= 0 {
            previousBarButtonItem.isEnabled = false
            nextBarButtonItem.isEnabled = true
        } else if offsetPage >= (totalPage - Constant.Page.count)  {
            previousBarButtonItem.isEnabled = true
            nextBarButtonItem.isEnabled = false
        } else {
            previousBarButtonItem.isEnabled = true
            nextBarButtonItem.isEnabled = true
        }
    }
    
    // MARK: Actions
    
    @IBAction func previousPage(sender: UIBarButtonItem) {
        currentPage -= 1
        offsetPage -= Constant.Page.count
        
        requestCharacterList()
    }
    
    @IBAction func nextPage(sender: UIBarButtonItem) {
        currentPage += 1
        offsetPage += Constant.Page.count
        
        requestCharacterList()
    }
}

// MARK: - Collection View DataSource & Collection View Delegate

extension CharacterListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interactor!.count()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseCollectionViewCellIdentifier, for: indexPath) as? CharacterCollectionViewCell else {
            preconditionFailure("Failed to load collection view cell")
        }
        
        fetchCharacterRowAndConfigure(cell, at: indexPath)
        
        return cell
    }
    
    func configureCell(_ cell: CharacterCollectionViewCell, withDisplayedCell displayedCell: CharacterListModel.DisplayedCell, at indexPath: IndexPath) {
        cell.nameLabel.text = displayedCell.name
        
        if let data = displayedCell.image {
            let image = UIImage(data: data)
            cell.thumbnailImageView.image = image
            cell.hideActivityIndicator()
        } else if let path = displayedCell.url, let ext = displayedCell.ext {
            cell.showActivityIndicator()
            cell.thumbnailImageView.image = UIImage(named: "image-background")
            let request = CharacterListModel.CoverImage.Request(url: path, size: .standardAmazing, ext: ext, indexPath: indexPath, cell: cell)
            interactor?.requestCharacterThumbnail(request: request)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionViewCellSelected = collectionView.cellForItem(at: indexPath)
        
        let request = CharacterListModel.CharacterDetail.Request(indexPath: indexPath)
        interactor?.provideDataStoreToCharacterDetail(request: request)
    }
}

// MARK: - NSFetchedResultsController
extension CharacterListViewController {
    
    // MARK: Character update lifecycle
    
    func startCharacterUpdates() {
        let request = CharacterListModel.StartCharacterListUpdates.Request()
        interactor?.startCharacterUpdates(request: request)
    }
    
    func stopCharacterUpdates() {
        let request = CharacterListModel.StopCharacterListUpdates.Request()
        interactor?.stopCharacterUpdates(request: request)
    }
    
    // MARK: Character row updates
    
    func displayInsertedRow(at indexPath: IndexPath) {
        collectionView.insertItems(at: [indexPath])
    }
    
    func displayDeletedRow(at indexPath: IndexPath) {
        collectionView.deleteItems(at: [indexPath])
    }
    
    func displayUpdatedRow(at indexPath: IndexPath, withDisplayedCharacter displayedCharacter: CharacterListModel.DisplayedCell) {
        let cell = collectionView.cellForItem(at: indexPath) as! CharacterCollectionViewCell
        
        configureCell(cell, withDisplayedCell: displayedCharacter, at: indexPath)
    }
    
    func displayMovedRow(from: IndexPath, to: IndexPath, withDisplayedCharacter displayedCharacter: CharacterListModel.DisplayedCell) {
        let cell = collectionView.cellForItem(at: from) as! CharacterCollectionViewCell
        
        configureCell(cell, withDisplayedCell: displayedCharacter, at: from)
        collectionView.moveItem(at: from, to: to)
    }
}

// MARK: - CharacterDetailTransitionAnimatorDelegate {
extension CharacterListViewController: CharacterDetailTransitionAnimatorDelegate {
    func transitionWillStart() {
        // We keep track of the last-selected cell, so we can show/hide it here.
        guard let cellSelected = collectionViewCellSelected else { return }
        cellSelected.isHidden = true
    }

    func transitionDidEnd() {
        guard let cellSelected = collectionViewCellSelected else { return }
        cellSelected.isHidden = false
    }

    func referenceImageView() -> UIImageView {
        guard let cellSelected = collectionViewCellSelected as? CharacterCollectionViewCell else {
            return UIImageView()
        }
        return cellSelected.thumbnailImageView
    }

    func imageFrame() -> CGRect? {
        guard let cellSelected = collectionViewCellSelected else {
            return nil
        }
        
        return collectionView.convert(cellSelected.frame, to: self.view)
    }
}
