//
//  UIViewController.swift
//  Muda
//
//  Created by Bowon Han on 7/29/24.
//

import UIKit

// MARK: - keyboard hide
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
