//
//  DiaryListViewController.swift
//  Muda
//
//  Created by Bowon Han on 7/29/24.
//

import UIKit
import SnapKit

protocol DiaryListViewControllerDelegate: AnyObject {
    func presentDiaryList()
    func presentDiary(viewModel: DiaryViewModel)
}

final class DiaryListViewController: BaseViewController {
    weak var delegate: DiaryListViewControllerDelegate?
    
    var dataSource: UICollectionViewDiffableDataSource<Section, DiaryModel>!
    private let viewModel = DiaryListViewModel(dataManager: DiaryListManager())
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupDataSource()
        performQuery(data: viewModel.diaryList)
    }
    
    private lazy var diaryListCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.delegate = self
    
        return collectionView
    }()
    
    // MARK: - collection view layout 설정
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection in
            
            let inset = CGFloat(10)
            /// 하나의 item 설정
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)

            /// 주 그룹 설정
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalHeight(0.4))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            ///  section 설정
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: 0, trailing: inset)

            return section
        }
        return layout
    }
    
    private func setupDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<DiaryListCollectionViewCell, DiaryModel> {
            (cell, indexPath, music) in
            
            
            let diaryVM = self.viewModel.diaryViewModelAtIndex(indexPath.row)
            cell.viewModel = diaryVM
        }
        
        self.dataSource = UICollectionViewDiffableDataSource<Section, DiaryModel>(collectionView: self.diaryListCollectionView) {
            (collectionView, indexPath, music) -> UICollectionViewCell? in
            return self.diaryListCollectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: music)
        }
    }
    
    private func performQuery(data: [DiaryModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, DiaryModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(data)
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIImageView(image: UIImage(named: "headerLogo")))
    }
    
    override func setupLayouts() {
        super.setupLayouts()
        
        [diaryListCollectionView].forEach {
            view.addSubview($0)
        }
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        diaryListCollectionView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - extension
extension DiaryListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.presentDiary(viewModel: viewModel.diaryViewModelAtIndex(indexPath.row))
    }
}
