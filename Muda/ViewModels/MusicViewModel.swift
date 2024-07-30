//
//  MusicViewModel.swift
//  Muda
//
//  Created by Bowon Han on 7/30/24.
//

import Foundation

final class MusicViewModel {
    private var musicData: Music
    
    init(musicData: Music) {
        self.musicData = musicData
    }
    
    var title: String {
        return musicData.title
    }
    
    var singer: String {
        return musicData.singer
    }
    
    var imageName: String {
        return musicData.imageName
    }
}
