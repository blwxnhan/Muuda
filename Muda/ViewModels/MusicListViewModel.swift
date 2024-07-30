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
    
    var musicList: [Music] {
        return musicListData
    }
    
    func setSearchText(_ text: String) {
        self.searchText = text
    }
    
    func musicViewModelAtIndex(_ index: Int) -> MusicViewModel {
        let music = self.musicList[index]
        return MusicViewModel(musicData: music)
    }
    
//    func changeToDiary(_ index: Int) -> DiaryModel {
//        let musicInfo = self.musicList[index]
//        let diary = DiaryModel(title: musicInfo.title,
//                               imageName: musicInfo.imageName,
//                               singer: musicInfo.singer,
//                               diary: nil,
//                               date: nil,
//                               color: nil,
//                               isLike: nil)
//        
//        return diary
//    }
    
    func changeToDiary(_ index: Int) -> DiaryViewModel {
        let musicInfo = self.musicList[index]
        let diary = DiaryModel(title: musicInfo.title, 
                               imageName: musicInfo.imageName,
                               singer: musicInfo.singer,
                               diary: nil,
                               date: nil,
                               color: nil,
                               isLike: nil)
        
        let diaryViewModel = DiaryViewModel(dataManager: DiaryListManager(), with: diary)
        
        return diaryViewModel
    }
    
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
