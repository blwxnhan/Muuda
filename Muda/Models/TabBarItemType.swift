//
//  TabBarItemType.swift
//  Muda
//
//  Created by Bowon Han on 7/29/24.
//

import Foundation

enum TabBarItemType: String, CaseIterable {
    case diaryList, musicList
    
    /// Int형에 맞춰 초기화
    init?(index: Int) {
        switch index {
        case 0: self = .diaryList
        case 1: self = .musicList
        default: return nil
        }
    }
    
    /// TabBarPage 형을 매칭되는 Int형으로 반환
    func toInt() -> Int {
        switch self {
        case .diaryList: return 0
        case .musicList: return 1
        }
    }
    
    /// TabBarPage 형을 매칭되는 한글명으로 변환
    func toKrName() -> String {
        switch self {
        case .diaryList: return "Diary"
        case .musicList: return "Music"
        }
    }
    
    /// TabBarPage 형을 매칭되는 아이콘명으로 변환
    func toIconName() -> String {
        switch self {
        case .diaryList: return "note.text"
        case .musicList: return "music.note"
        }
    }
}
