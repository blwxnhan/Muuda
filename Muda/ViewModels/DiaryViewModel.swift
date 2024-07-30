//
//  DiaryViewModel.swift
//  Muda
//
//  Created by Bowon Han on 7/29/24.
//

import Foundation

class DiaryViewModel {
    let dataManager: DiaryListType
    
    private var diaryData: DiaryModel?
    private var index: Int?
    
    init(dataManager: DiaryListType, with diary: DiaryModel? = nil, index: Int? = nil) {
        self.dataManager = dataManager
        self.diaryData = diary
        self.index = index
    }
    
    var title: String {
        guard let title = diaryData?.title else { return "" }
        return title
    }
    
    var singer: String {
        guard let singer = diaryData?.singer else { return "" }
        return singer
    }
    
    var imageName: String? {
        guard let imageName = diaryData?.imageName else { return "" }
        return imageName
    }
    
    var diary: String? {
        return diaryData?.diary
    }
    
    var date: Date? {
        return diaryData?.date
    }
    
    var color: ColorsType? {
        return diaryData?.color
    }
}
