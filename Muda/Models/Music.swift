//
//  MusicListResDto.swift
//  Muda
//
//  Created by Bowon Han on 7/29/24.
//

import Foundation

enum Section: CaseIterable {
    case main
}

struct MusicList: Codable, Hashable {
    let resultCount : Int
    let results : [Music]
}

struct Music: Codable, Hashable {
    let id = UUID()
    let title : String
    let imageName : String
    let singer : String
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case imageName = "artworkUrl100"
        case singer = "artistName"
    }
}
