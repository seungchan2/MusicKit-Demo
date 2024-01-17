//
//  MusicDemoApp.swift
//  MusicDemo
//
//  Created by 김승찬 on 2024/01/17.
//

import SwiftUI

@main
struct MusicDemoApp: App {
    var body: some Scene {
        WindowGroup {
            SearchView(viewModel: SearchViewModel(repository: SearchMusicRepository()))
        }
    }
}
