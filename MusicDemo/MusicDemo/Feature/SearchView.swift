//
//  SearchView.swift
//  MusicDemo
//
//  Created by 김승찬 on 2024/01/17.
//

import SwiftUI

struct SearchView: View {
    @State private var musicInfo: [MusicInfo] = []
    @StateObject var viewModel: SearchViewModel
    @State private var searchText: String = ""
    @State var page: Int = 1
    
    var body: some View {
        VStack {
            TextField("Search Music",
                      text: $searchText,
                      onCommit: {
                viewModel.fetchedMusicList.removeAll()
                viewModel.send(action: .searchMusic(page: page, query: searchText))
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            List {
                contentView
            }
            .background(Color.white)
        }
    }
    
    var contentView: some View {
        ForEach(viewModel.fetchedMusicList) { data in
            SearchItemView(title: data.title,
                           artist: data.artistName,
                           genre: data.genre,
                           date: Date(),
                           albumArtwork: data.albumArtwork)
            .padding(.horizontal, 10)
            .onAppear {
                guard let index = viewModel.fetchedMusicList.firstIndex(where: { $0.id == data.id }) else { return }
                                
                if index == viewModel.fetchedMusicList.count - 1 {
                    page += 1
                    viewModel.send(action: .searchMusic(page: page, query: searchText))
                }
            }
        }
    }
}

struct SearchItemView: View {
    let title: String
    let artist: String
    let genre: String
    let date: Date
    let albumArtwork: URL?
    
    var body: some View {
        VStack {
            if let url = albumArtwork {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .frame(width: 75, height: 75, alignment: .center)
                    default:
                        Text("Loading...")
                            .foregroundColor(.black)
                    }
                }
            }
            Text("Title: \(title)")
                .foregroundColor(.black)
            
            Text("Artist: \(artist)")
                .foregroundColor(.black)
            
            Text("Genre: \(genre)")
                .foregroundColor(.black)
        }
    }
}
