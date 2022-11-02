//
//  ViewController.swift
//  PhotosLibrary
//
//  Created by Oleksandr Khalypa on 29.10.2022.
//

import UIKit

class PhotosViewController: UIViewController {
    
    private let mainView = PhotosView()
    private let viewModel: PhotoViewModelProtocol!
    private var timer: Timer?
    
    init(viewModel: PhotoViewModelProtocol = PhotoViewModel()) {
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
        viewModel.initialFetchPhotos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func bindViewModel() {
        viewModel.photoModel.bind { [weak self] photos in
            guard let self = self else { return }
            guard let photos = photos else { return }
            DispatchQueue.main.async {
                self.mainView.configure(photos: photos.results)
            }
        }
        
        mainView.searchTerm.bind { [weak self] searchTerm in
            guard let self = self else { return }
            if searchTerm == nil {
                self.viewModel.initialFetchPhotos()
            }
            guard let searchTerm = searchTerm else { return }
            
            if self.timer != nil {
                self.timer?.invalidate()
            }
            self.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
                self.viewModel.fetchPhotos(searchTerm: searchTerm)
            })
        }
        
        mainView.didClick =  { [weak self] unsplashPhoto in
            let detailVC = DetailsViewController()
            detailVC.unsplashPhoto = unsplashPhoto
            self?.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
