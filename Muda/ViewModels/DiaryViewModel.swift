//
//  DiaryViewModel.swift
//  Muda
//
//  Created by Bowon Han on 7/29/24.
//

import Foundation

final class DiaryViewModel {
    let dataManager: DiaryListType
    
    private var diaryData: DiaryModel?
    
    init(dataManager: DiaryListType, with diary: DiaryModel? = nil) {
        self.dataManager = dataManager
        self.diaryData = diary
    }
    
    // MARK: - output
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
    
    var isLike: Bool? {
        return diaryData?.isLike
    }
    
    // MARK: - input
    func handleFinishedButtonTapped(
        title: String,
        imageName: String,
        singer: String,
        diary: String,
        date: Date,
        color: ColorsType,
        isLike: Bool
    ) {
        if self.diaryData?.date != nil {
            updateDiary(
                title: title,
                imageName: imageName,
                singer: singer,
                diary: diary,
                date: date,
                color: color,
                isLike: isLike
            )
        } else {
            makeNewDiary(
                id: UUID(),
                title: title,
                imageName: imageName,
                singer: singer,
                diary: diary,
                date: date,
                color: color,
                isLike: isLike
            )
        }
    }
    
    func handleDeleteButtonTapped(
        title: String,
        imageName: String,
        singer: String,
        diary: String,
        date: Date,
        color: ColorsType,
        isLike: Bool
    ) {
        deleteDiary(
            title: title,
            imageName: imageName,
            singer: singer,
            diary: diary,
            date: date,
            color: color,
            isLike: isLike
        )
    }

    // MARK: - Logic
    private func makeNewDiary(
        id: UUID,
        title: String,
        imageName: String,
        singer: String,
        diary: String,
        date: Date,
        color: ColorsType,
        isLike: Bool
    ) {
        let newDiary = DiaryModel(
            id: id,
            title: title,
            imageName: imageName,
            singer: singer,
            diary: diary,
            date: date,
            color: color,
            isLike: isLike
        )
        
        self.dataManager.makeNewDiary(newDiary)
    }
    
    private func updateDiary(
         title: String,
         imageName: String,
         singer: String,
         diary: String,
         date: Date,
         color: ColorsType,
         isLike: Bool
    ) {
        guard let diaryData = self.diaryData else { return }
        
        let updateDiaryData = DiaryModel(
            exitingDiary: diaryData,
            diary: diary,
            date: date,
            color: color,
            isLike: isLike
        )
        
        self.dataManager.updateDiaryInfo(updateDiaryData)
    }
    
    private func deleteDiary(
         title: String,
         imageName: String,
         singer: String,
         diary: String,
         date: Date,
         color: ColorsType,
         isLike: Bool
    ) {
             
        guard let diaryData = self.diaryData else { return }
        
        let deleteDiaryData = DiaryModel(
            exitingDiary: diaryData,
            diary: diary,
            date: date,
            color: color,
            isLike: isLike
        )
        
        self.dataManager.deleteDiary(deleteDiaryData)
    }
}
