//
//  BaseViewController.swift
//  Muda
//
//  Created by Bowon Han on 7/29/24.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayouts()
        setupConstraints()
        setupStyles()
    }
    
    func setupLayouts() {}
    
    func setupConstraints() {}
    
    func setupStyles() {}
}
