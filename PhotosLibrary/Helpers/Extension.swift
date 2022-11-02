//
//  Extension.swift
//  PhotosLibrary
//
//  Created by Oleksandr Khalypa on 01.11.2022.
//

import UIKit

extension UIViewController {
    func addAlert(with title: String,
                            message: String,
                            actionButtonTitle: String,
                            cancelButtonTitle: String,
                            completion: @escaping () -> ()) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionButton = UIAlertAction(title: actionButtonTitle, style: .default) { action in
            completion()
        }
        let cancelButton = UIAlertAction(title: cancelButtonTitle, style: .cancel)
        alertController.addAction(actionButton)
        alertController.addAction(cancelButton)
        present(alertController, animated: true)
    }
}
