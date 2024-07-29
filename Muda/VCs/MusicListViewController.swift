//
//  MusicListViewController.swift
//  Muda
//
//  Created by Bowon Han on 7/29/24.
//

import UIKit
import SnapKit
import Moya

final class MusicListViewController: BaseViewController {
    private var musicListManager: [Music] = []
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Music>!
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        self.setupDataSource()
        
        self.fetchMusicInfo(searchText: "new jeans")
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
            self?.fetchMusicInfo(searchText: self?.searchBar.text ?? "")
        }, for: .touchUpInside)
        
        return button
    }()
    
    private lazy var musicListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1.0
        layout.minimumLineSpacing = 1.0
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
    
        return collectionView
    }()
    
    private func setupDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<MusicListCollectionViewCell, Music> {
            (cell, indexPath, music) in
            cell.configureData(data: self.musicListManager[indexPath.row])
        }
        
        self.dataSource = UICollectionViewDiffableDataSource<Section, Music>(collectionView: self.musicListCollectionView) {
            (collectionView, indexPath, music) -> UICollectionViewCell? in
            return self.musicListCollectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: music)
        }
    }
    
    private func performQuery(data: [Music]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Music>()
        snapshot.appendSections([.main])
        snapshot.appendItems(data)
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func fetchMusicInfo(searchText: String) {
        let provider = MoyaProvider<APIService>()
        provider.request(.fetchMusic(term: searchText)) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(response):
                    let result = try? response.map(MusicList.self)
                    
                    if let result = result {
                        self.musicListManager = result.results
                        self.performQuery(data: self.musicListManager)
                    }
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
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
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = collectionView.frame.width
        let height: CGFloat = (collectionView.frame.width / 3) - 57.0
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let diaryVC = DiaryViewController()
        self.present(diaryVC, animated: true)
    }
}
