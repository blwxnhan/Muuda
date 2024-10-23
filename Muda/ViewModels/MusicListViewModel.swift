//
//  MusicListViewModel.swift
//  Muda
//
//  Created by Bowon Han on 7/30/24.
//

import Foundation
import Moya
import Combine
import UIKit

final class MusicListViewModel {
    var cancellables = Set<AnyCancellable>()
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Music>!
    var snapshot = NSDiffableDataSourceSnapshot<Section, Music>()
    
    private var musicListData: [Music] = []
    @Published var searchText: String = ""
    
    init() {
        $searchText.receive(on: RunLoop.main)
        .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
        .sink { (_) in
          self.fetchMusicList()
        }.store(in: &cancellables)
    }
    
    // MARK: - output
    var musicList: [Music] {
        return musicListData
    }
    
    // MARK: - input
    func setSearchText(_ text: String) {
        self.searchText = text
    }
    
    func musicViewModelAtIndex(_ index: Int) -> MusicViewModel {
        let music = self.musicList[index]
        return MusicViewModel(musicData: music)
    }
    
    /// Music 데이터를 Diary 데이터로 변환하는 메서드
    func changeToDiary(_ index: Int) -> DiaryViewModel {
        let musicInfo = self.musicList[index]
        
        let diary = DiaryModel(
            title: musicInfo.title,
            imageName: musicInfo.imageName,
            singer: musicInfo.singer,
            diary: nil,
            date: nil,
            color: nil,
            isLike: nil
        )
            
        let diaryViewModel = DiaryViewModel(dataManager: DiaryListManager(), with: diary)
        
        return diaryViewModel
    }
    
    func fetchMusicList() {
        print("fetchMusicList", searchText)
        APIService().fetchMusics(of: searchText)
              .sink { completion in
                switch completion {
                case .finished:
                  print("ViewModel searchMovies finished")
                case .failure(let error):
                  print("ViewModel searchMovies failure: \(error.localizedDescription)")
                }
              } receiveValue: { musics in
                        // api를 통해 값을 받으면 해당 데이터를 diffableDataSource에 넣는다.
                self.snapshot.deleteAllItems()
                self.snapshot.appendSections([.main])
                
                if musics.isEmpty {
                            // 3.
                  self.dataSource.apply(self.snapshot, animatingDifferences: true)
                  return
                }
                self.snapshot.appendItems(musics)
                self.dataSource.apply(self.snapshot, animatingDifferences: true)
              }
              .store(in: &cancellables)
          }
}
