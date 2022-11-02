//
//  FavouritesViewController.swift
//  PhotosLibrary
//
//  Created by Oleksandr Khalypa on 29.10.2022.
//

import UIKit

class FavouritesViewController: UIViewController {
    
    private let mainView = FavouritesView()
    private let viewModel: FavouritesViewModelProtocol!
    
    init(viewModel: FavouritesViewModelProtocol = FavouritesViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = "Favourite"
        viewModel.getFavouritePhotos()
    }
    
    private func bindViewModel() {
        viewModel.photoModel.bind { [weak self] photos in
            guard let self = self else { return }
            guard let photos = photos else { return }
            DispatchQueue.main.async {
                self.mainView.configure(photos: photos)
            }
        }
        
        mainView.didClick =  { [weak self] favoritePhoto in
            let detailVC = DetailsViewController()
            detailVC.favoritePhoto = favoritePhoto
            self?.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
