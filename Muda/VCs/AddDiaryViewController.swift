//
//  AddDiary.swift
//  Muda
//
//  Created by Bowon Han on 7/30/24.
//

import UIKit
import SnapKit

protocol AddDiaryViewControllerDelegate: AnyObject {
    func presentAddDiary(viewModel: DiaryViewModel)
}

final class AddDiaryViewController: BaseViewController {
    weak var delegate: AddDiaryViewControllerDelegate?
    private var selectedColor: [Bool] = [false, false, false, false, false]
    
    private let viewModel: DiaryViewModel
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(viewModel: DiaryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private lazy var musicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .myGray
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    private var musicTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Super Shy"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        
        return label
    }()
    
    private var musicSingerLabel: UILabel = {
        let label = UILabel()
        label.text = "New Jeans"
        label.font = .systemFont(ofSize: 17, weight: .light)
        
        return label
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .black
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
        let setImage = UIImage(systemName: "heart", withConfiguration: imageConfig)
        config.image = setImage
        
        button.configuration = config
        
        return button
    }()
    
    private let seperatedLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .myGray
        
        return view
    }()
    
    private let diaryLabel = DescriptionLabel(title: "Diary")
    private let diaryTextView: UITextView = {
        let textView = UITextView()
        textView.layer.cornerRadius = 10
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.myGray.cgColor
        textView.layer.masksToBounds = true
        textView.font = .systemFont(ofSize: 15, weight: .medium)
        
        return textView
    }()
    
    private let colorLabel = DescriptionLabel(title: "Color")
    private let colorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.layer.borderWidth = 1
        stackView.layer.borderColor = UIColor.myGray.cgColor
        stackView.layer.cornerRadius = 10
        stackView.layer.masksToBounds = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        return stackView
    }()
    
    private lazy var firstColorButton = ColorButton(color: ColorsType.first, selected: selectedColor[0])
    private lazy var secondColorButton = ColorButton(color: ColorsType.second, selected: selectedColor[1])
    private lazy var thirdColorButton = ColorButton(color: ColorsType.third, selected: selectedColor[2])
    private lazy var fourthColorButton = ColorButton(color: ColorsType.fourth, selected: selectedColor[3])
    private lazy var fifthColorButton = ColorButton(color: ColorsType.fifth, selected: selectedColor[4])
    
    private let dateLabel = DescriptionLabel(title: "Date")
    private var datePicker: UIDatePicker = {
        var datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .compact
        datePicker.layer.cornerRadius = 10
        datePicker.layer.borderWidth = 1
        datePicker.layer.borderColor = UIColor.myGray.cgColor
        datePicker.layer.masksToBounds = true
        
        return datePicker
    }()
    
    private lazy var finishedButton: UIButton = {
        let button = UIButton()
        
        var config = UIButton.Configuration.filled()
        config.baseForegroundColor = .third
        config.baseBackgroundColor = .fourth
        
        var titleAttr = AttributedString.init("저장하기")
        titleAttr.font = .systemFont(ofSize: 17, weight: .medium)
        
        config.attributedTitle = titleAttr
        button.configuration = config
        
        return button
    }()
    
    private func configureUI() {
        guard let imageUrl = self.viewModel.imageName else { return }
        requestImageURL(url: imageUrl)
        musicTitleLabel.text = viewModel.title
        musicSingerLabel.text = viewModel.singer
        diaryTextView.text = viewModel.diary
        if let color = viewModel.color {
            selectedColor[color.toInt()] = true
        }
        datePicker.date = viewModel.date ?? Date()
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
    
    override func setupLayouts() {
        super.setupLayouts()
        
        [firstColorButton, 
         secondColorButton,
         thirdColorButton,
         fourthColorButton,
         fifthColorButton].forEach {
            colorStackView.addArrangedSubview($0)
        }
        
        [musicImageView, 
         musicTitleLabel,
         musicSingerLabel,
         likeButton,
         seperatedLineView,
         diaryLabel,
         diaryTextView,
         colorLabel,
         colorStackView,
         dateLabel,
         datePicker,
        finishedButton].forEach {
            view.addSubview($0)
        }
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        musicImageView.snp.makeConstraints {
            $0.top.leading.equalTo(view.safeAreaLayoutGuide).offset(25)
            $0.height.width.equalTo(130)
        }
        
        musicTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(musicImageView.snp.trailing).offset(15)
            $0.top.equalTo(musicImageView.snp.top).offset(60)
            $0.height.equalTo(30)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-25)
        }
        
        musicSingerLabel.snp.makeConstraints {
            $0.top.equalTo(musicTitleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(musicTitleLabel.snp.leading)
            $0.height.equalTo(25)
            $0.trailing.equalTo(musicTitleLabel.snp.trailing)
        }
        
        likeButton.snp.makeConstraints {
            $0.top.equalTo(musicImageView.snp.top).offset(1)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-25)
            $0.height.width.equalTo(30)
        }
        
        seperatedLineView.snp.makeConstraints {
            $0.top.equalTo(musicImageView.snp.bottom).offset(28)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(1)
        }
        
        diaryLabel.snp.makeConstraints {
            $0.top.equalTo(seperatedLineView.snp.bottom).offset(28)
            $0.leading.equalTo(seperatedLineView.snp.leading).offset(5)
            $0.height.equalTo(20)
        }
        
        diaryTextView.snp.makeConstraints {
            $0.top.equalTo(diaryLabel.snp.bottom).offset(5)
            $0.leading.equalTo(diaryLabel.snp.leading).offset(-3)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            $0.height.equalTo(200)
        }
        
        colorLabel.snp.makeConstraints {
            $0.top.equalTo(diaryTextView.snp.bottom).offset(30)
            $0.leading.equalTo(diaryLabel.snp.leading)
            $0.height.equalTo(20)
        }
        
        colorStackView.snp.makeConstraints {
            $0.top.equalTo(colorLabel.snp.bottom).offset(5)
            $0.leading.equalTo(colorLabel.snp.leading).offset(-3)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            $0.height.equalTo(80)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(colorStackView.snp.bottom).offset(30)
            $0.leading.equalTo(diaryLabel.snp.leading)
            $0.height.equalTo(20)
        }
        
        datePicker.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(5)
            $0.leading.equalTo(dateLabel.snp.leading).offset(-3)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            $0.height.equalTo(60)
        }
        
        finishedButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(45)
        }
    }
}
