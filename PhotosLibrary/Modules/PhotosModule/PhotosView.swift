//
//  PhotosView.swift
//  PhotosLibrary
//
//  Created by Oleksandr Khalypa on 29.10.2022.
//

import UIKit
import WaterfallLayout

class PhotosView: UIView {
    
    private(set) var photos: [UnsplashPhoto] = []
    
    var searchTerm: Dynamic<String?> = Dynamic(nil)
    var didClick: ((UnsplashPhoto) -> Void)?
    
    private let collectionView: UICollectionView = {
        let waterfallLayout = WaterfallLayout()
        let obj = UICollectionView(frame: .zero,
                                   collectionViewLayout: waterfallLayout)
        obj.contentInsetAdjustmentBehavior = .automatic
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.backgroundColor = .white
        obj.allowsMultipleSelection = true
        obj.showsVerticalScrollIndicator = false
        return obj
    }()
    
    private let searchBar: UISearchBar = {
        let obj = UISearchBar()
        obj.backgroundImage = UIImage()
        obj.placeholder = "Пошук"
        obj.searchTextField.textColor = .black
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(photos: [UnsplashPhoto]) {
        self.photos = photos
        collectionView.reloadData()
    }
    
    private func setupUI() {
        self.backgroundColor = .white
        addSubview(searchBar)
        searchBar.delegate = self
        addSubview(collectionView)
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        addConstraint()
    }
    
    private func addConstraint() {
        let margins = self.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            searchBar.topAnchor.constraint(equalTo: margins.topAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
    }
}


extension PhotosView: UICollectionViewDelegateWaterfallLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, numberOfColumnsInSection section: Int) -> Int {
        return traitCollection.horizontalSizeClass == .compact ? 2 : 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if !photos.isEmpty {
            let photo = photos[indexPath.item]
            return CGSize(width: photo.width, height: photo.height)
        }
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 12, left: 24, bottom: 12, right: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumColumnSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
}

extension PhotosView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.showsCancelButton = true
        searchTerm.value = searchText
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = nil
        searchTerm.value = nil
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
