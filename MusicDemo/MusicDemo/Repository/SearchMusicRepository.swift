//
//  SearchMusicRepository.swift
//  MusicDemo
//
//  Created by 김승찬 on 2024/01/17.
//

import Foundation
import MusicKit
import Combine

protocol SearchMusicRepositoryType {
    func getMusicInfo(query: String) -> Future<[MusicInfo], Error>
}

final class SearchMusicRepository: SearchMusicRepositoryType {
    func getMusicInfo(query: String) -> Future<[MusicInfo], Error> {
        return Future { promise in
            Task {
                let status = await MusicAuthorization.request()
                
                switch status {
                case .authorized:
                    do {
                        var request = MusicCatalogSearchRequest(term: query, types: [Song.self])
                        
                        request.limit = 25
                        request.offset = 1
                        
                        let result = try await request.response()
                        
                        let musicInfo: [MusicInfo] = result.songs.compactMap { song in
                            MusicInfo(
                                title: song.title,
                                artistName: song.artistName,
                                genre: song.genreNames.first!,
                                albumArtwork: song.artwork?.url(width: 75, height: 75)
                            )
                        }
                        promise(.success(musicInfo))
                    } catch {
                        promise(.failure(error))
                    }
                default:
                    break
                }
            }
        }
    }
}
