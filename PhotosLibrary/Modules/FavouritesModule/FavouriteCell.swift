//
//  FavouriteCell.swift
//  PhotosLibrary
//
//  Created by Oleksandr Khalypa on 30.10.2022.
//

import UIKit

class FavouriteCell: UICollectionViewCell {
    
    static let identifier = "FavouriteCell"
    
    private let imageView: UIImageView = {
        let obj = UIImageView()
        obj.clipsToBounds = true
        obj.image = UIImage(named: "imageDemo")
        obj.contentMode = .scaleAspectFill
        obj.layer.cornerRadius = 10
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    private let bottomView: UIView = {
        let obj = UIView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    private let avatarImageView: UIImageView = {
        let obj = UIImageView()
        obj.clipsToBounds = true
        obj.image = UIImage(named: "avatarDemo")
        obj.contentMode = .scaleAspectFill
        obj.layer.cornerRadius = 10
        obj.backgroundColor = .red
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    private let nameLabel: UILabel = {
        let obj = UILabel()
        obj.textColor = .black
        obj.text = "David Malon"
        obj.font = .systemFont(ofSize: 14, weight: .semibold)
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    private let heartImageView: UIImageView = {
        let obj = UIImageView()
        obj.clipsToBounds = true
        obj.contentMode = .scaleAspectFill
        obj.image = UIImage(named: "heart.fill")
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    var favoritePhoto: FavoritePhotos! {
        didSet {
            imageView.image = UIImage(data: favoritePhoto.mainImage)
            avatarImageView.image = UIImage(data: favoritePhoto.profileImage)
            nameLabel.text = favoritePhoto.name
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setup() {
        contentView.addSubview(imageView)
        contentView.addSubview(bottomView)
        bottomView.addSubview(avatarImageView)
        bottomView.addSubview(nameLabel)
        bottomView.addSubview(heartImageView)
        
        addConstraint()
    }
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomView.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            bottomView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 28),
            bottomView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
            avatarImageView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 20),
            avatarImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            heartImageView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            heartImageView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor),
            heartImageView.widthAnchor.constraint(equalToConstant: 20),
            heartImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: heartImageView.leadingAnchor, constant: -5),
            nameLabel.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor)
        ])
    }
    
}
