//
//  DiaryViewController.swift
//  Muda
//
//  Created by Bowon Han on 7/29/24.
//

import UIKit
import SnapKit

protocol DiaryViewControllerDelegate: AnyObject {
    func presentAddDiary(viewModel: DiaryViewModel, type: AddType)
}

final class DiaryViewController: BaseViewController {
    weak var delegate: DiaryViewControllerDelegate?
    
    var viewModel: DiaryViewModel! {
        didSet {
            configureUI()
        }
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
    }
    
    // MARK: - configure UI
    private lazy var editDiaryButton: UIButton = {
        let button = UIButton()
        
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .black
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
        let setImage = UIImage(systemName: "pencil", withConfiguration: imageConfig)
        config.image = setImage
        
        button.configuration = config
        button.addAction(UIAction { [weak self] _ in
            guard let viewModel = self?.viewModel else { return }
            self?.delegate?.presentAddDiary(viewModel: viewModel, type: AddType.update)
        }, for: .touchUpInside)
        
        return button
    }()
    
    private let musicView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
    
        return view
    }()
    
    private lazy var musicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .myGray
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    private let musicTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        
        return label
    }()
    
    private let musicSingerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .light)
        
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textAlignment = .center
        
        return label
    }()
    
    private let diaryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.numberOfLines = 0
        label.setLineSpacing(lineSpacing: 20)
        
        return label
    }()
    
    private let diaryLabelContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.myGray.cgColor
        view.clipsToBounds = true
        
        return view
    }()
    
    private func configureUI() {
        musicView.backgroundColor = viewModel.color?.toUIColor()
        requestImageURL(data: viewModel.imageName)
        musicTitleLabel.text = viewModel.title
        musicSingerLabel.text = viewModel.singer
        dateLabel.text = viewModel.date?.basic
        diaryLabel.text = viewModel.diary
    }
    
    private func requestImageURL(data: String?) {
        guard let imageUrl = data else { return }
        guard let url = URL(string: imageUrl) else { return }
        
        let backgroundQueue = DispatchQueue(label: "background_queue",qos: .background)
        
        backgroundQueue.async {
            guard let data = try? Data(contentsOf: url) else { return }
            
            DispatchQueue.main.async {
                self.musicImageView.image = UIImage(data: data)
            }
        }
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: editDiaryButton)
    }
    
    override func setupLayouts() {
        super.setupLayouts()
        
        diaryLabelContainerView.addSubview(diaryLabel)
        
        [musicImageView, 
         musicTitleLabel,
         musicSingerLabel].forEach {
            musicView.addSubview($0)
        }
        
        [musicView,
         dateLabel,
         diaryLabelContainerView].forEach {
            view.addSubview($0)
        }
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        musicView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(150)
        }
        
        musicImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(20)
            $0.height.equalTo(musicImageView.snp.width)
        }
        
        musicSingerLabel.snp.makeConstraints {
            $0.bottom.equalTo(musicImageView.snp.bottom)
            $0.leading.equalTo(musicImageView.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        musicTitleLabel.snp.makeConstraints {
            $0.bottom.equalTo(musicSingerLabel.snp.top)
            $0.leading.equalTo(musicSingerLabel.snp.leading).offset(-3)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(musicView.snp.bottom).offset(15)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.height.equalTo(25)
        }
        
        diaryLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(diaryLabelContainerView).inset(10)
            $0.top.equalTo(diaryLabelContainerView).inset(10)
        }
        
        diaryLabelContainerView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
        }
    }
}
