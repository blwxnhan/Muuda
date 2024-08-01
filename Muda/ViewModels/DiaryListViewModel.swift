//
//  DiaryListViewModel.swift
//  Muda
//
//  Created by Bowon Han on 7/29/24.
//

import Foundation

class DiaryListViewModel {
    private let dataManager: DiaryListType
    
    private var diaryListData: [DiaryModel] {
        return dataManager.getDiarysList()
    }
    
    init(dataManager: DiaryListType) {
        self.dataManager = dataManager
    }
    
    var diaryList: [DiaryModel] {
        return diaryListData
    }

    func diaryViewModelAtIndex(_ index: Int) -> DiaryViewModel {
        let diary = self.diaryListData[index]
        return DiaryViewModel(dataManager: self.dataManager, with: diary, index: index)
    }
    
    func addDiary(_ diary: DiaryModel) {
        dataManager.makeNewDiary(diary)
    }
}
