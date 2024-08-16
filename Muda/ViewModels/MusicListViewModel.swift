//
//  MusicListViewModel.swift
//  Muda
//
//  Created by Bowon Han on 7/30/24.
//

import Foundation
import Moya

final class MusicListViewModel {
    private var musicListData: [Music] = []
    private var searchText: String?
    
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
    
    /// Apple Music API로부터 데이터를 받아오는 메서드
    func fetchMusicList(completion: @escaping (() -> Void)) {
        guard let text = self.searchText else { return }
        
        let provider = MoyaProvider<APIService>()
        
        provider.request(.fetchMusic(term: text)) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(response):
                    let result = try? response.map(MusicList.self)
                    
                    if let result = result {
                        self.musicListData = result.results
                        completion()
                    }
                    
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}
