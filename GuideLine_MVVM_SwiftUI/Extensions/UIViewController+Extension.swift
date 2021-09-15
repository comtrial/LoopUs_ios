//
//  UIViewController+Extension.swift
//  GuideLine_MVVM_SwiftUI
//
//  Created by 최승원 on 2021/07/14.
//

import UIKit
import SwiftUI

extension UIViewController {
    func presentAlert(with message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        present(alert, animated: true)
    }
}

extension View{
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
