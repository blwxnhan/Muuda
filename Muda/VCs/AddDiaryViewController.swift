//
//  AddDiary.swift
//  Muda
//
//  Created by Bowon Han on 7/30/24.
//

import UIKit
import SnapKit

enum AddType {
    case create
    case update
}

protocol AddDiaryViewControllerDelegate: AnyObject {
    func dismiss()
    func backToRoot()
}

final class AddDiaryViewController: BaseViewController {
    weak var delegate: AddDiaryViewControllerDelegate?
    
    private var selectedButton: ColorButton?
    private var selectedColor: [Bool] = [false, false, false, false, false]
    
    private let viewModel: DiaryViewModel
    private let addType: AddType
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        self.hideKeyboardWhenTappedAround()
        
        setupButtons()
    }
    
    init(viewModel: DiaryViewModel, type: AddType) {
        self.addType = type
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
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        
        var config = UIButton.Configuration.filled()
        config.baseForegroundColor = .third
        config.baseBackgroundColor = UIColor.init(hexCode: "DEB0B0")
        
        var titleAttr = AttributedString.init("삭제하기")
        titleAttr.font = .systemFont(ofSize: 17, weight: .medium)
        
        config.attributedTitle = titleAttr
        button.configuration = config
        button.addAction(UIAction { [weak self] _ in
            self?.clickDeleteButton()
            self?.delegate?.dismiss()
            self?.delegate?.backToRoot()
        }, for: .touchUpInside)
        
        return button
    }()
    
    private let contentView = UIView()
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        return scrollView
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
        button.addAction(UIAction { [weak self] _ in
            self?.clickFinishedButton()
            self?.delegate?.dismiss()
            self?.delegate?.backToRoot()
        }, for: .touchUpInside)
        
        return button
    }()
    
    private func setupButtons() {
        firstColorButton.addTarget(self, action: #selector(colorButtonTapped(_:)), for: .touchUpInside)
        secondColorButton.addTarget(self, action: #selector(colorButtonTapped(_:)), for: .touchUpInside)
        thirdColorButton.addTarget(self, action: #selector(colorButtonTapped(_:)), for: .touchUpInside)
        fourthColorButton.addTarget(self, action: #selector(colorButtonTapped(_:)), for: .touchUpInside)
        fifthColorButton.addTarget(self, action: #selector(colorButtonTapped(_:)), for: .touchUpInside)
    }

    @objc private func colorButtonTapped(_ sender: ColorButton) {
        /// 기존에 선택된 버튼이 있으면 선택 해제
        selectedButton?.isSelected = false

        /// 새로 선택된 버튼을 선택 상태로 전환
        sender.isSelected = true
        selectedButton = sender
    }

    
    private func clickFinishedButton() {
        guard let imageName = viewModel.imageName else { return }
        
        viewModel.handleFinishedButtonTapped(
            title: viewModel.title,
            imageName: imageName,
            singer: viewModel.singer,
            diary: diaryTextView.text,
            date: datePicker.date,
            color: selectedButtonToColorType(),
            isLike: true
        )
    }
    
    private func clickDeleteButton() {
        print("삭제됨")
        guard let imageName = viewModel.imageName else { return }

        viewModel.handleDeleteButtonTapped(
            title: viewModel.title,
            imageName: imageName,
            singer: viewModel.singer,
            diary: diaryTextView.text,
            date: datePicker.date,
            color: selectedButtonToColorType(),
            isLike: true
        )
    }
    
    private func configureUI() {
        guard let imageUrl = self.viewModel.imageName else { return }
        ImageNetwork.requestImageURL(data: imageUrl, imageView: musicImageView)
        
        musicTitleLabel.text = viewModel.title
        musicSingerLabel.text = viewModel.singer
        diaryTextView.text = viewModel.diary

        if let color = viewModel.color {
            let selectedIndex = color.toInt()
            selectedColor[selectedIndex] = true

            updateButtonSelection(for: selectedIndex)
        }
        
        datePicker.date = viewModel.date ?? Date()
    }
    
    private func selectedButtonToColorType() -> ColorsType {
        switch selectedButton {
        case firstColorButton:
                .first
        case secondColorButton:
                .second
        case thirdColorButton:
                .third
        case fourthColorButton:
                .fourth
        case fifthColorButton:
                .fifth
        default:
                .first
        }
    }

    private func updateButtonSelection(for selectedIndex: Int) {
        /// 기존에 선택된 버튼의 상태를 모두 해제
        firstColorButton.isSelected = false
        secondColorButton.isSelected = false
        thirdColorButton.isSelected = false
        fourthColorButton.isSelected = false
        fifthColorButton.isSelected = false

        /// 해당 색상에 맞는 버튼을 선택된 상태로 설정
        switch selectedIndex {
        case 0:
            firstColorButton.isSelected = true
            selectedButton = firstColorButton
        case 1:
            secondColorButton.isSelected = true
            selectedButton = secondColorButton
        case 2:
            thirdColorButton.isSelected = true
            selectedButton = thirdColorButton
        case 3:
            fourthColorButton.isSelected = true
            selectedButton = fourthColorButton
        case 4:
            fifthColorButton.isSelected = true
            selectedButton = fifthColorButton
        default:
            break
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
        
        switch addType {
        case .create:
            [diaryLabel,
             diaryTextView,
             colorLabel,
             colorStackView,
             dateLabel,
             datePicker].forEach {
                contentView.addSubview($0)
            }
        case .update:
            [diaryLabel,
             diaryTextView,
             colorLabel,
             colorStackView,
             dateLabel,
             datePicker,
            deleteButton].forEach {
                contentView.addSubview($0)
            }
        }
    
        scrollView.addSubview(contentView)
        
        [musicImageView,
         musicTitleLabel,
         musicSingerLabel,
         seperatedLineView,
         scrollView,
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
        
        seperatedLineView.snp.makeConstraints {
            $0.top.equalTo(musicImageView.snp.bottom).offset(28)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(1)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(seperatedLineView.snp.bottom).offset(2)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(finishedButton.snp.top).offset(-10)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
            $0.height.equalTo(600)
        }
        
        diaryLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(25)
            $0.height.equalTo(20)
        }
        
        diaryTextView.snp.makeConstraints {
            $0.top.equalTo(diaryLabel.snp.bottom).offset(5)
            $0.leading.equalTo(diaryLabel.snp.leading).offset(-3)
            $0.trailing.equalToSuperview().offset(-25)
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
            $0.trailing.equalTo(diaryTextView.snp.trailing)
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
            $0.trailing.equalTo(diaryTextView.snp.trailing)
            $0.height.equalTo(60)
        }
        
        switch addType {
        case .create: break
        case .update:
            deleteButton.snp.makeConstraints {
                $0.top.equalTo(datePicker.snp.bottom).offset(10)
                $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
                $0.height.equalTo(45)
            }
        }
        
        finishedButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(45)
        }
    }
}
