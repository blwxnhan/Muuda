//
//  DescriptionLabel .swift
//  Muda
//
//  Created by Bowon Han on 7/30/24.
//

import UIKit

final class DescriptionLabel: UILabel {
    private let title: String
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        setupStyles()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupStyles() {
        self.text = title
        self.font = .systemFont(ofSize: 14, weight: .bold)
        self.textAlignment = .center
    }
}
