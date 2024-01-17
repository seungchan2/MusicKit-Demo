//
//  MusicInfo.swift
//  MusicDemo
//
//  Created by 김승찬 on 2024/01/17.
//

import Foundation

struct MusicInfo: Hashable, Identifiable {
    let title: String
    let artistName: String
    let genre: String
    let albumArtwork: URL?
    var id: String { title }
}
