//
//  MusicListCollectionViewCell.swift
//  Muda
//
//  Created by Bowon Han on 7/29/24.
//

import UIKit
import SnapKit

final class MusicListCollectionViewCell: UICollectionViewCell {
    private var playToggle: Bool = true
    
    private var musicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    private var musicTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        return label
    }()
    
    private var singerNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        
        return label
    }()
    
    private lazy var musicSettingButton: UIButton = {
        let button = UIButton()
        
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemBackground
        config.baseForegroundColor = .black
        button.configuration = config
        button.configurationUpdateHandler = handler
        button.isSelected = false
        button.addAction(UIAction { [weak self] _ in
            self?.playButtonclick()
        }, for: .touchUpInside)
        
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private let handler: UIButton.ConfigurationUpdateHandler = { button in
        switch button.state {
        case .selected:
            button.configuration?.image = UIImage(systemName: "heart.fill")
        default:
            button.configuration?.image = UIImage(systemName: "heart")
        }
    }
    
    private func playButtonclick() {
        musicSettingButton.isSelected.toggle()
        playToggle.toggle()
    }
    
    private func requestImageURL(url: String) {
        guard let url = URL(string: url) else { return }
        
        let backgroundQueue = DispatchQueue(label: "background_queue",qos: .background)
        
        backgroundQueue.async {
            guard let data = try? Data(contentsOf: url) else { return }
            
            DispatchQueue.main.async {
                self.musicImageView.image = UIImage(data: data)
            }
        }
    }
    
    func configureData(data: Music) {
        requestImageURL(url: data.imageName)
        musicTitleLabel.text = data.title
        singerNameLabel.text = data.singer
    }

    private func setLayout() {
        [musicImageView,
         musicTitleLabel,
         singerNameLabel,
         musicSettingButton].forEach {
            addSubview($0)
        }
        
        musicImageView.snp.makeConstraints {
            $0.leading.equalTo(self).offset(20)
            $0.centerY.equalTo(self)
            $0.height.width.equalTo(70)
        }
        
        musicTitleLabel.snp.makeConstraints {
            $0.top.equalTo(musicImageView.snp.top).offset(3)
            $0.leading.equalTo(musicImageView.snp.trailing).offset(20)
            $0.width.equalTo(200)
        }
        
        singerNameLabel.snp.makeConstraints {
            $0.top.equalTo(musicTitleLabel.snp.top)
            $0.leading.equalTo(musicImageView.snp.trailing).offset(20)
            $0.bottom.equalTo(self).offset(-5)
        }
        
        musicSettingButton.snp.makeConstraints {
            $0.centerY.equalTo(self)
            $0.trailing.equalTo(self).offset(-30)
            $0.height.equalTo(30)
            $0.width.equalTo(30)
        }
    }
}
