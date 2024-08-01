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
    
    func makeNewDiary(title: String, 
                      imageName: String,
                      singer: String,
                      diary: String,
                      date: Date,
                      color: ColorsType,
                      isLike: Bool) {
        let newDiary = DiaryModel(title: title,
                                  imageName: imageName,
                                  singer: singer,
                                  diary: diary,
                                  date: date,
                                  color: color,
                                  isLike: isLike)
        
        self.dataManager.makeNewDiary(newDiary)
    }
    
    func updateDiary(title: String,
                             imageName: String,
                             singer: String,
                             diary: String,
                             date: Date,
                             color: ColorsType,
                             isLike: Bool) {
        
        guard let diaryData = self.diaryData,
              let index = self.index else { return }
        
        let updateDiaryData = DiaryModel(exitingDiary: diaryData, diary: diary, date: date, color: color, isLike: isLike)
        
        
        self.dataManager.updateDiaryInfo(updateDiaryData)
    }
    
    func handleButtonTapped(title: String,
                            imageName: String,
                            singer: String,
                            diary: String,
                            date: Date,
                            color: ColorsType,
                            isLike: Bool) {
        if self.diaryData?.date != nil {
            updateDiary(title: title, imageName: imageName, singer: singer, diary: diary, date: date, color: color, isLike: isLike)
        } else {
            makeNewDiary(title: title, imageName: imageName, singer: singer, diary: diary, date: date, color: color, isLike: isLike)
        }
    }
}
