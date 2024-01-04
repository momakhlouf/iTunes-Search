//
//  SongViewModel.swift
//  iTunesSearchApp
//
//  Created by Mohamed Makhlouf Ahmed on 02/01/2024.
//

import Foundation
import Combine

class SongViewModel: ObservableObject{
    
    let networkManager = NetworkingManager()
    @Published var songs : [Song] = []

    @Published var searchTerm: String = ""
    @Published var state: FetchState = .good
    
    var cancellables = Set<AnyCancellable>()

    
    init(){
        $searchTerm
            .removeDuplicates()
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
                self?.state = .good
                self?.songs = []
                self?.fetchSongs(for: term)
            }
            .store(in: &cancellables)
        
    }
    
    func fetchSongs(for term: String){
        guard !searchTerm.isEmpty else{
            return
        }
      
        guard state == FetchState.good else {
            return
        }
        state = .isLoading

        networkManager.fetchSongs(searchTerm: searchTerm)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: {[weak self] completion in
                    self?.networkManager.handleCompletion(completion)
                }, receiveValue: { [weak self] result in
                 //   for song in result.results {
                    self?.songs = result.results
                   // }
                  //  self?.page += 1
              //      self?.state = (result.results.count == self?.limit) ? .good : .loadedAll

                })
                .store(in: &cancellables)
        }
    
    func loadMore(){
        fetchSongs(for: searchTerm)
    }
    
    
    static func mockSong() -> SongViewModel{
        let vm = SongViewModel()
        vm.songs = [Song.mockSong()]
        return vm
    }

    
}
