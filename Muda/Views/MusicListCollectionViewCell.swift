//
//  MusicListCollectionViewCell.swift
//  Muda
//
//  Created by Bowon Han on 7/29/24.
//

import UIKit
import SnapKit

final class MusicListCollectionViewCell: UICollectionViewCell {
    var viewModel: MusicViewModel! {
        didSet {
            configureData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setLayout()
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
     
    private func configureData() {
        requestImageURL(url: viewModel.imageName)
        musicTitleLabel.text = viewModel.title
        singerNameLabel.text = viewModel.singer
    }

    private func setLayout() {
        [musicImageView,
         musicTitleLabel,
         singerNameLabel].forEach {
            addSubview($0)
        }
        
        musicImageView.snp.makeConstraints {
            $0.leading.equalTo(self).offset(10)
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
    }
}
