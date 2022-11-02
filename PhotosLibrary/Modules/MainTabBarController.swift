//
//  MainTabBarController.swift
//  PhotosLibrary
//
//  Created by Oleksandr Khalypa on 29.10.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.isTranslucent = false
        UITabBar.appearance().barTintColor = .white
        self.tabBar.tintColor = .black
        
        let photosVC = PhotosViewController()
        let favouriteVC = FavouritesViewController()
        
        guard let homeImage = UIImage(named: "home"),
              let heartImage = UIImage(named: "heart") else { return }
        
        viewControllers = [
            generateNavigationController(rootViewController: photosVC, title: "Home", image: homeImage),
            generateNavigationController(rootViewController: favouriteVC, title: "Favourite", image: heartImage)
        ]
    }
    
    private func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }
}

