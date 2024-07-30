//
//  DiaryListManager.swift
//  Muda
//
//  Created by Bowon Han on 7/29/24.
//

import Foundation

protocol DiaryListType {
    func makeDiarysListDatas()
    func getDiarysList() -> [DiaryModel]
    func makeNewDiary(_ diary: DiaryModel)
    func updateDiaryInfo(index: Int, with diary: DiaryModel)
    subscript(index: Int) -> DiaryModel { get set }
}


final class DiaryListManager: DiaryListType {
    
    /// 멤버리스트를 저장하기 위한 배열
    private var diaryList: [DiaryModel] = []
    
    init() {
        makeDiarysListDatas()
    }
    
    func makeDiarysListDatas() {
        diaryList = [
            DiaryModel(title: "OMG",
                       imageName: "https://i.namu.wiki/i/DHZA28_vXGoWuHXJ-Mg4DMzKfs2lbENtijX1uWdZ_b1me4tfzhnVyYtuJDJwGd2j2e73S5CODt5yzxtPY87c6HcWOUnxtbK50pmxdymXAOVBtg6xlEla3xJKbmqtW8JHVDxBZN815oXwkgT2HKWKsw.jpg",
                       singer: "New Jeans",
                       diary: "재미있다 재미있다!!!", 
                       date: Date(),
                       color: .fourth,
                       isLike: true),
            
            DiaryModel(title: "Super Shy",
                       imageName: "https://i.namu.wiki/i/DHZA28_vXGoWuHXJ-Mg4DMzKfs2lbENtijX1uWdZ_b1me4tfzhnVyYtuJDJwGd2j2e73S5CODt5yzxtPY87c6HcWOUnxtbK50pmxdymXAOVBtg6xlEla3xJKbmqtW8JHVDxBZN815oXwkgT2HKWKsw.jpg",
                       singer: "New Jeans",
                       diary: "뉴진스 신곡나옴!!!  넘나 귀여운것!! 오마이갓 화잍팅!!! 뉴진스 신곡나옴!!!  뉴진스 신곡나옴!!!  넘나 귀여운것!! 오마이갓 화잍팅!!! 뉴진스 신곡나옴!!!  뉴진스 신곡나옴!!!  넘나 귀여운것!! 오마이갓 화잍팅!!! 뉴진스 신곡나옴!!!  뉴진스 신곡나옴!!!  넘나 귀여운것!! 오마이갓 화잍팅!!! 뉴진스 신곡나옴!!!  뉴진스 신곡나옴!!!  넘나 귀여운것!! 오마이갓 화잍팅!!! 뉴진스 신곡나옴!!!  뉴진스 신곡나옴!!!  넘나 귀여운것!! 오마이갓 화잍팅!!! 뉴진스 신곡나옴!!",
                       date: Date(),
                       color: .fifth,
                       isLike: true),
            
            DiaryModel(title: "Home Sweet",
                       imageName: "https://i.namu.wiki/i/DHZA28_vXGoWuHXJ-Mg4DMzKfs2lbENtijX1uWdZ_b1me4tfzhnVyYtuJDJwGd2j2e73S5CODt5yzxtPY87c6HcWOUnxtbK50pmxdymXAOVBtg6xlEla3xJKbmqtW8JHVDxBZN815oXwkgT2HKWKsw.jpg",
                       singer: "New Jeans",
                       diary: "뉴진스 신곡나옴!!!  넘나 귀여운것!! 오마이갓 화잍팅!!! 뉴진스 신곡나옴!!!  뉴진스 신곡나옴!!!  넘나 귀여운것!! 오마이갓 화잍팅!!! 뉴진스 신곡나옴!!!  뉴진스 신곡나옴!!!  넘나 귀여운것!! 오마이갓 화잍팅!!! 뉴진스 신곡나옴!!!  뉴진스 신곡나옴!!!  넘나 귀여운것!! 오마이갓 화잍팅!!! 뉴진스 신곡나옴!!!  뉴진스 신곡나옴!!!  넘나 귀여운것!! 오마이갓 화잍팅!!! 뉴진스 신곡나옴!!!  뉴진스 신곡나옴!!!  넘나 귀여운것!! 오마이갓 화잍팅!!! 뉴진스 신곡나옴!!",
                       date: Date(),
                       color: .fifth,
                       isLike: true),
            
            DiaryModel(title: "Super Natural",
                       imageName: "https://i.namu.wiki/i/DHZA28_vXGoWuHXJ-Mg4DMzKfs2lbENtijX1uWdZ_b1me4tfzhnVyYtuJDJwGd2j2e73S5CODt5yzxtPY87c6HcWOUnxtbK50pmxdymXAOVBtg6xlEla3xJKbmqtW8JHVDxBZN815oXwkgT2HKWKsw.jpg",
                       singer: "New Jeans",
                       diary: "뉴진스 신곡나옴!!!  넘나 귀여운것!! 오마이갓 화잍팅!!! 뉴진스 신곡나옴!!!  뉴진스 신곡나옴!!!  넘나 귀여운것!! 오마이갓 화잍팅!!! 뉴진스 신곡나옴!!!  뉴진스 신곡나옴!!!  넘나 귀여운것!! 오마이갓 화잍팅!!! 뉴진스 신곡나옴!!!  뉴진스 신곡나옴!!!  넘나 귀여운것!! 오마이갓 화잍팅!!! 뉴진스 신곡나옴!!!  뉴진스 신곡나옴!!!  넘나 귀여운것!! 오마이갓 화잍팅!!! 뉴진스 신곡나옴!!!  뉴진스 신곡나옴!!!  넘나 귀여운것!! 오마이갓 화잍팅!!! 뉴진스 신곡나옴!!",
                       date: Date(),
                       color: .fourth,
                       isLike: true),
            
            DiaryModel(title: "Ditto",
                       imageName: "https://i.namu.wiki/i/DHZA28_vXGoWuHXJ-Mg4DMzKfs2lbENtijX1uWdZ_b1me4tfzhnVyYtuJDJwGd2j2e73S5CODt5yzxtPY87c6HcWOUnxtbK50pmxdymXAOVBtg6xlEla3xJKbmqtW8JHVDxBZN815oXwkgT2HKWKsw.jpg",
                       singer: "New Jeans",
                       diary: "뉴진스 신곡나옴!!!  넘나 귀여운것!! 오마이갓 화잍팅!!! 뉴진스 신곡나옴!!!  뉴진스 신곡나옴!!!  넘나 귀여운것!! 오마이갓 화잍팅!!! 뉴진스 신곡나옴!!!  뉴진스 신곡나옴!!!  넘나 귀여운것!! 오마이갓 화잍팅!!! 뉴진스 신곡나옴!!!  뉴진스 신곡나옴!!!  넘나 귀여운것!! 오마이갓 화잍팅!!! 뉴진스 신곡나옴!!!  뉴진스 신곡나옴!!!  넘나 귀여운것!! 오마이갓 화잍팅!!! 뉴진스 신곡나옴!!!  뉴진스 신곡나옴!!!  넘나 귀여운것!! 오마이갓 화잍팅!!! 뉴진스 신곡나옴!!",
                       date: Date(),
                       color: .first,
                       isLike: true),
            
            DiaryModel(title: "Super Shy",
                       imageName: "https://i.namu.wiki/i/DHZA28_vXGoWuHXJ-Mg4DMzKfs2lbENtijX1uWdZ_b1me4tfzhnVyYtuJDJwGd2j2e73S5CODt5yzxtPY87c6HcWOUnxtbK50pmxdymXAOVBtg6xlEla3xJKbmqtW8JHVDxBZN815oXwkgT2HKWKsw.jpg",
                       singer: "New Jeans",
                       diary: "뉴진스 신곡나옴!!!  넘나 귀여운것!! 오마이갓 화잍팅!!! 뉴진스 신곡나옴!!!  뉴진스 신곡나옴!!!  넘나 귀여운것!! 오마이갓 화잍팅!!! 뉴진스 신곡나옴!!!  뉴진스 신곡나옴!!!  넘나 귀여운것!! 오마이갓 화잍팅!!! 뉴진스 신곡나옴!!!  뉴진스 신곡나옴!!!  넘나 귀여운것!! 오마이갓 화잍팅!!! 뉴진스 신곡나옴!!!  뉴진스 신곡나옴!!!  넘나 귀여운것!! 오마이갓 화잍팅!!! 뉴진스 신곡나옴!!!  뉴진스 신곡나옴!!!  넘나 귀여운것!! 오마이갓 화잍팅!!! 뉴진스 신곡나옴!!",
                       date: Date(),
                       color: .fourth,
                       isLike: true),
        ]
    }
    
    func getDiarysList() -> [DiaryModel] {
        return diaryList
    }
    
    func makeNewDiary(_ diary: DiaryModel) {
        diaryList.append(diary)
    }
    
    func updateDiaryInfo(index: Int, with diary: DiaryModel) {
        diaryList[index] = diary
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
