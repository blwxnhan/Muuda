//
//  DiaryListViewModel.swift
//  Muda
//
//  Created by Bowon Han on 7/29/24.
//

import Foundation

final class DiaryListViewModel {
    private let dataManager: DiaryListType
    
    private var diaryListData: [DiaryModel] {
        return dataManager.getDiarysList()
    }
    
    init(dataManager: DiaryListType) {
        self.dataManager = dataManager
    }
    
    // MARK: - output
    var diaryList: [DiaryModel] {
        return diaryListData
    }

    // MARK: - input
    func diaryViewModelAtIndex(_ index: Int) -> DiaryViewModel {
        let diary = self.diaryListData[index]
        return DiaryViewModel(dataManager: self.dataManager, with: diary)
    }
    
    func addDiary(_ diary: DiaryModel) {
        dataManager.makeNewDiary(diary)
    }
}
