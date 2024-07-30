//
//  DiaryListCollectionViewCell.swift
//  Muda
//
//  Created by Bowon Han on 7/29/24.
//

import UIKit
import SnapKit

final class DiaryListCollectionViewCell: UICollectionViewCell {
    var viewModel: DiaryViewModel! {
        didSet {
            configureUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayouts()
        setStyles()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private var musicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    private let musicTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textAlignment = .left
        
        return label
    }()
    
    private let musicSingerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 9, weight: .regular)
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .black
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 13, weight: .medium)
        let setImage = UIImage(systemName: "heart.fill", withConfiguration: imageConfig)
        config.image = setImage
        
        button.configuration = config
        
        return button
    }()
    
    private let diaryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.numberOfLines = 3
        
        return label
    }()
    
    private func requestImageURL(data: String) {
        guard let url = URL(string: data ) else { return }
        
        let backgroundQueue = DispatchQueue(label: "background_queue",qos: .background)
        
        backgroundQueue.async {
            guard let data = try? Data(contentsOf: url) else { return }
            
            DispatchQueue.main.async {
                self.musicImageView.image = UIImage(data: data)
            }
        }
    }
    
    private func configureUI() {
        guard let imageName = viewModel.imageName else { return }
        requestImageURL(data: imageName)
        musicTitleLabel.text = viewModel.title
        musicSingerLabel.text = viewModel.singer
        diaryLabel.text = viewModel.diary
    }
    
    private func setStyles() {
        self.layer.shadowColor = UIColor.myGray.cgColor
        self.layer.shadowPath = UIBezierPath(rect: CGRect(x: self.bounds.origin.x - 0.5, y: self.bounds.origin.y - 0.5, width: self.bounds.width + 0.5, height: self.bounds.height + 0.5)).cgPath
        self.layer.shadowOpacity = 10
        self.layer.shadowRadius = 6
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.masksToBounds = true
        self.contentView.backgroundColor = .first
    }
    
    private func setLayouts() {
        [musicImageView,
        musicTitleLabel,
        musicSingerLabel,
         likeButton,
        diaryLabel].forEach {
            contentView.addSubview($0)
        }
        
        musicImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(musicImageView.snp.width)
        }
        
        musicTitleLabel.snp.makeConstraints {
            $0.top.equalTo(musicImageView.snp.bottom).offset(8)
            $0.leading.equalTo(musicImageView.snp.leading).offset(5)
            $0.trailing.equalTo(likeButton.snp.leading).offset(-3)
            $0.height.equalTo(12)
        }
        
        musicSingerLabel.snp.makeConstraints {
            $0.top.equalTo(musicTitleLabel.snp.bottom).offset(3)
            $0.leading.equalTo(musicTitleLabel.snp.leading)
            $0.trailing.equalTo(likeButton.snp.leading).offset(-3)
            $0.height.equalTo(9)
        }
        
        likeButton.snp.makeConstraints {
            $0.trailing.equalTo(musicImageView.snp.trailing).offset(-5)
            $0.top.equalTo(musicImageView.snp.bottom).offset(10)
            $0.height.width.equalTo(13)
        }
        
        diaryLabel.snp.makeConstraints {
            $0.top.equalTo(musicSingerLabel.snp.bottom).offset(5)
            $0.bottom.equalToSuperview().offset(-15)
            $0.trailing.equalTo(likeButton.snp.trailing).offset(-3)
            $0.leading.equalTo(musicTitleLabel.snp.leading)
        }
    }
}
