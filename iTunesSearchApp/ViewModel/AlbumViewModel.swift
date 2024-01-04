//
//  AlbumViewModel.swift
//  iTunesSearchApp
//
//  Created by Mohamed Makhlouf Ahmed on 30/12/2023.
//

import Foundation
import Combine

enum FetchState: Comparable {
    case good
    case isLoading
    case loadedAll
    case error(String)
}

class AlbumViewModel: ObservableObject{
    let networkManager = NetworkingManager()
    
  
    
  
    
    @Published var albums : [Album] = []
    @Published var movies : [Movie] = []

    @Published var searchTerm: String = ""
    @Published var state: FetchState = .good

    var cancellables = Set<AnyCancellable>()

     
    let limit = 20
    var page  = 0
    
    init(){
        $searchTerm
            .removeDuplicates()
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
          //  .receive(on: DispatchQueue.main)
            .sink { [weak self] term in
                self?.state = .good
                self?.albums = []
                self?.fetchAlbums(for: term)
            }
            .store(in: &cancellables)
        
    }
    

    
    func loadMore(){
        fetchAlbums(for: searchTerm)
    }
    
    
    func fetchAlbums(for term: String){
        
        guard !searchTerm.isEmpty else{
            return
        }
      
        guard state == FetchState.good else {
            return
        }
        state = .isLoading

        networkManager.fetchAlbums(searchTerm: searchTerm, page: page, limit: limit)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: {[weak self] completion in
                    self?.networkManager.handleCompletion(completion)
                }, receiveValue: { [weak self] result in
                    for album in result.results {
                        self?.albums.append(album)
                    }
                    self?.page += 1
                    self?.state = (result.results.count == self?.limit) ? .good : .loadedAll

                })
                .store(in: &cancellables)
        }
    
    static func mockAlbum() -> AlbumViewModel{
        let vm = AlbumViewModel()
        vm.albums = [Album.mockAlbum()]
        return vm
    }
   

}
