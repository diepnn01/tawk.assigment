//
//  UIViewController+Extension.swift
//  Tawk Interview
//
//  Created by Diep Nguyen on 23/05/2022.
//

import UIKit
extension UIViewController {

    func showNetworkAlert() {
        let alert = UIAlertController(title: "Warning", message: "Network do not avaiable", preferredStyle: .alert)
        let action = UIAlertAction(title: "Go to Settings", style: .default) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}
