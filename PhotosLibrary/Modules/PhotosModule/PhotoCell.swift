//
//  PhotosCellCollectionViewCell.swift
//  PhotosLibrary
//
//  Created by Oleksandr Khalypa on 29.10.2022.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    static let identifier = "PhotosCell"
    
    private var imageDataTask: URLSessionDataTask?
    
    private static let cache = URLCache(
        memoryCapacity: 50 * 1024 * 1024,
        diskCapacity: 100 * 1024 * 1024,
        diskPath: "photo"
    )
    
    private let imageView: UIImageView = {
        let obj = UIImageView()
        obj.clipsToBounds = true
        obj.backgroundColor = .lightGray
        obj.contentMode = .scaleAspectFill
        obj.layer.cornerRadius = 10
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    var unsplashPhoto: UnsplashPhoto! {
        didSet {
            let photoUrl = unsplashPhoto.urls["regular"]
            guard let imageUrl = photoUrl, let url = URL(string: imageUrl) else { return }
            
            downloadPhoto(url: url) { [weak self] image, error in
                guard let slf = self, error == nil else { return }
                UIView.transition(
                    with: slf.imageView,
                    duration: 0.2,
                    options: [.transitionCrossDissolve],
                    animations: { slf.imageView.image = image },
                    completion: nil
                )

            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        imageDataTask = nil
    }
    
    
   private func downloadPhoto(url: URL, completion: @escaping (UIImage?, Error?) -> Void) {
        if let cachedResponse = PhotoCell.cache.cachedResponse(for: URLRequest(url: url)),
            let image = UIImage(data: cachedResponse.data) {
            completion(image, nil)
            return
        }
        
        imageDataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
            self?.imageDataTask = nil
            
            if let error = error {
                DispatchQueue.main.async { completion(nil, error) }
                return
            }
            
            guard let data = data, let image = UIImage(data: data), error == nil else { return }
            DispatchQueue.main.async { completion(image, nil) }
        }
        
        imageDataTask?.resume()
        
    }
}
