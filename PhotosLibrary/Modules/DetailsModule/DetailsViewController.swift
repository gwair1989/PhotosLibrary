//
//  DetailsViewController.swift
//  PhotosLibrary
//
//  Created by Oleksandr Khalypa on 30.10.2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var unsplashPhoto: UnsplashPhoto?
    var favoritePhoto: FavoritePhotos?
    let viewModel: DetailsViewModelProtocol!
    private let mainView = DetailsView()
    
    init(viewModel: DetailsViewModelProtocol = DetailsViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        
        if let photo = unsplashPhoto {
            mainView.config(photo: photo)
        }
        
        if let photo = favoritePhoto {
            mainView.config(favoritePhoto: photo)
        }

        mainView.likeButton.addTarget(self, action: #selector(likeButtonTap), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }
    
    private func setupNavBar() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.isTranslucent = false
        let backImage = UIImage(named: "blackButton")
        navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationController?.navigationBar.backItem?.title = ""
        
        let shareItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(shareTapped))
        shareItem.image = UIImage(named: "share")
        navigationItem.rightBarButtonItem = shareItem
        self.navigationItem.title = "Details"
    }
    
    @objc func shareTapped() {
        
        guard let selectedImage = mainView.imageView.image else { return }
        
        let shareController = UIActivityViewController(activityItems: [selectedImage], applicationActivities: nil)
        shareController.popoverPresentationController?.permittedArrowDirections = .any
        present(shareController, animated: true, completion: nil)
        
    }
    
    @objc func likeButtonTap() {
        
        if let unsplashPhoto = unsplashPhoto {
            addAlert(with: "", message: "Do you want to add to your favorites?", actionButtonTitle: "OK", cancelButtonTitle: "Cancel") {
                guard let mainImageData = self.mainView.imageView.image?.pngData(),
                      let avatarImageData = self.mainView.avatarImageView.image?.pngData()
                else { return }
                self.viewModel.addInFovourites(photo: FavoritePhotos(name: unsplashPhoto.user.name, createdAt: unsplashPhoto.createdAt,
                                                                 height: Int16(unsplashPhoto.height),
                                                                 id: unsplashPhoto.id,
                                                                 likes: Int16(unsplashPhoto.likes),
                                                                 mainImage: mainImageData,
                                                                 profileImage: avatarImageData,
                                                                 width: Int16(unsplashPhoto.width)))
            }
        }
        
        if let favoritePhoto = favoritePhoto {
            addAlert(with: "", message: "Do you want to remove from your favorites?", actionButtonTitle: "OK", cancelButtonTitle: "Cancel") {
                self.viewModel.remove(id: favoritePhoto.id)
            }
        }

    }
}

