//
//  SearchViewModel.swift
//  MusicDemo
//
//  Created by 김승찬 on 2024/01/17.
//

import Combine
import Foundation

final class SearchViewModel: ObservableObject {
    
    private var repository: SearchMusicRepositoryType
    private var cancellables: Set<AnyCancellable> = []
    @Published var fetchedMusicList: [MusicInfo] = []

    init(repository: SearchMusicRepositoryType) {
        self.repository = repository
    }
    
    enum Action {
        case searchMusic(query: String)
    }
    
    func send(action: Action) {
        switch action {
        case let .searchMusic(query):
            self.searchMusic(query: query)
        }
    }
    
    private func searchMusic(query: String) {
        repository.getMusicInfo(query: query)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in},
                  receiveValue: { data in
                self.fetchedMusicList = data
            })
            .store(in: &cancellables)
    }
}
