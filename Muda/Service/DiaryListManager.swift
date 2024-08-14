//
//  DiaryListManager.swift
//  Muda
//
//  Created by Bowon Han on 7/29/24.
//

import CoreData
import UIKit

protocol DiaryListType {
    func makeDiarysListDatas()
    func getDiarysList() -> [DiaryModel]
    func makeNewDiary(_ diary: DiaryModel)
    func updateDiaryInfo(_ diary: DiaryModel)
    func deleteDiary(_ diary: DiaryModel)
    subscript(index: Int) -> DiaryModel { get set }
}

final class DiaryListManager: DiaryListType {
    
    /// 멤버리스트를 저장하기 위한 배열
    private var diaryList: [DiaryModel] = []
    
    init() {
        makeDiarysListDatas()
    }
    
    func makeDiarysListDatas() {
        if let diaryList = CoreDataManager.shared.fetchData() {
            self.diaryList = diaryList
        }
    }
    
    func getDiarysList() -> [DiaryModel] {
        if let diaryList = CoreDataManager.shared.fetchData() {
            self.diaryList = diaryList
        }
        
        return diaryList
    }
    
    func makeNewDiary(_ diary: DiaryModel) {
        CoreDataManager.shared.saveData(with: diary)
    }
    
    func updateDiaryInfo(_ diary: DiaryModel) {
        CoreDataManager.shared.updateData(with: diary)
    }
    
    func deleteDiary(_ diary: DiaryModel) {
        CoreDataManager.shared.deleteData(with: diary)
    }
    
    subscript(index: Int) -> DiaryModel {
        get {
            return diaryList[index]
        }
        set {
            diaryList[index] = newValue
        }
    }
}
