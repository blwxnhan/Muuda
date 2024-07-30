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
    
    var title: String? {
        return diaryData?.title
    }
    
    var singer: String? {
        return diaryData?.singer
    }
    
    var imageName: String? {
        return diaryData?.imageName
    }
    
    var diary: String? {
        return diaryData?.diary
    }
    
    var date: Date? {
        return diaryData?.date
    }
    
    
}
