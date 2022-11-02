//
//  FavouritesView.swift
//  PhotosLibrary
//
//  Created by Oleksandr Khalypa on 30.10.2022.
//

import UIKit

class FavouritesView: UIView {
    
    var photos = [FavoritePhotos]()
    
    var didClick: ((FavoritePhotos) -> Void)?
    
    let itemsPerRow: CGFloat = 2
    let sectionInserts = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
    let heightBottomView: CGFloat = 32
    
    private let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 24
        flowLayout.minimumInteritemSpacing = 8
        let obj = UICollectionView(frame: .zero,
                                   collectionViewLayout: flowLayout)
        obj.contentInsetAdjustmentBehavior = .automatic
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.backgroundColor = .white
        obj.allowsMultipleSelection = false
        obj.showsVerticalScrollIndicator = false
        return obj
    }()
    
    
    init() {
        super.init(frame: CGRect.zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(photos: [FavoritePhotos]) {
        self.photos = photos
        collectionView.reloadData()
    }
    
    private func setupUI() {
        self.backgroundColor = .white
        addSubview(collectionView)
        collectionView.register(FavouriteCell.self, forCellWithReuseIdentifier: FavouriteCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        addConstraint()
    }
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}




