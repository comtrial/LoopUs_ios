//
//  UIViewController+Extension.swift
//  GuideLine_MVVM_SwiftUI
//
//  Created by 최승원 on 2021/07/14.
//

import UIKit

extension UIViewController {
    func presentAlert(with message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        present(alert, animated: true)
    }
}
