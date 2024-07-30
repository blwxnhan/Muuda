//
//  DiaryModel.swift
//  Muda
//
//  Created by Bowon Han on 7/29/24.
//

import Foundation

struct DiaryModel: Codable, Hashable {
    var id = UUID()
    let title : String
    let imageName : String
    let singer : String
    var diary: String?
    var date: Date?
    var color: ColorsType?
    var isLike: Bool?
    
    /// 글 새롭게 생성할때
    init(title: String,
         imageName: String,
         singer: String,
         diary: String?,
         date: Date?,
         color: ColorsType?,
         isLike: Bool?) {
        self.title = title
        self.imageName = imageName
        self.singer = singer
        self.diary = diary
        self.date = date
        self.color = color
        self.isLike = isLike
    }
    
    /// 기존 글 업데이트 할때
    init(exitingDiary: DiaryModel,
         diary: String?,
         date: Date?,
         color: ColorsType?,
         isLike: Bool?) {
        
        self = exitingDiary
        self.diary = diary
        self.date = date
        self.color = color
        self.isLike = isLike
    }
}
