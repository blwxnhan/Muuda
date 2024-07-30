//
//  ColorButton.swift
//  Muda
//
//  Created by Bowon Han on 7/30/24.
//

import UIKit

final class ColorButton: UIButton {
    private let color: ColorsType
    private let select: Bool
    
    init(color: ColorsType, selected: Bool) {
        self.color = color
        self.select = selected
        super.init(frame: .zero)
        setupStyles()
    }
    
    required init?(coder: NSCoder) {
         fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
    
    private let handler: UIButton.ConfigurationUpdateHandler = { button in
        switch button.state {
        case .selected:
            button.layer.borderWidth = 3
            button.layer.borderColor = UIColor.black.cgColor
        default:
            button.layer.borderWidth = 0
        }
    }
    
    func setupStyles() {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = color.toUIColor()

        self.configuration = config

        self.configurationUpdateHandler = handler
        self.isSelected = self.select
        self.addAction(UIAction { [weak self] _ in
            self?.isSelected.toggle()
        }, for: .touchUpInside)
        
        self.snp.makeConstraints {
            $0.height.width.equalTo(55)
        }
    }
}
