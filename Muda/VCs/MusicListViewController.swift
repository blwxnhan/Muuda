//
//  MusicListViewController.swift
//  Muda
//
//  Created by Bowon Han on 7/29/24.
//

import UIKit
import SnapKit
import Moya

protocol MusicListViewControllerDelegate: AnyObject {
    func presentMusicList()
    func presentAddDiary()
}

final class MusicListViewController: BaseViewController {
    weak var delegate: MusicListViewControllerDelegate?
    
    private var musicListManager: [Music] = []
    var dataSource: UICollectionViewDiffableDataSource<Section, Music>!
    
    private let viewModel = MusicListViewModel()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        setupDataSource()
        
        fetchMusicInfo(searchText: "new jeans")
        setupNavigationBar()
    }
    
    private var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = false
        searchBar.placeholder = "검색어를 입력해주세요"
        
        return searchBar
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("검색", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addAction(UIAction { [weak self] _ in
            guard let text = self?.searchBar.text else { return }
            self?.fetchMusicInfo(searchText: text)
        }, for: .touchUpInside)
        
        return button
    }()
    
    private lazy var musicListCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.delegate = self
    
        return collectionView
    }()
    
    private func setupDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<MusicListCollectionViewCell, Music> {
            (cell, indexPath, music) in
            
            let musicVM = self.viewModel.musicViewModelAtIndex(indexPath.row)
            cell.viewModel = musicVM
        }
        
        self.dataSource = UICollectionViewDiffableDataSource<Section, Music>(collectionView: self.musicListCollectionView) {
            (collectionView, indexPath, music) -> UICollectionViewCell? in
            return self.musicListCollectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: music)
        }
    }
    
    // MARK: - collection view layout 설정
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection in
            
            let inset = CGFloat(10)
            /// 하나의 item 설정
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)

            /// 주 그룹 설정
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(90))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            ///  section 설정
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0)

            return section
        }
        return layout
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIImageView(image: UIImage(named: "headerLogo")))
    }
    
    private func performQuery(data: [Music]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Music>()
        snapshot.appendSections([.main])
        snapshot.appendItems(data)
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func fetchMusicInfo(searchText: String) {
        viewModel.setSearchText(searchText)
        viewModel.fetchMusicList {
            self.performQuery(data: self.viewModel.musicList)
        }
    }
    
    override func setupLayouts() {
        super.setupLayouts()
        
        [searchBar,
         musicListCollectionView,
         searchButton].forEach {
            view.addSubview($0)
        }
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.equalTo(searchButton.snp.leading).offset(-5)
        }
        
        searchButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(searchBar.snp.trailing).offset(5)
            $0.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalTo(60)
            $0.height.equalTo(searchBar.snp.height)
        }
        
        musicListCollectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - extension
extension MusicListViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.presentAddDiary()
    }
}
