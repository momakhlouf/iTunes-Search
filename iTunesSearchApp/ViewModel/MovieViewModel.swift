//
//  MovieViewModel.swift
//  iTunesSearchApp
//
//  Created by Mohamed Makhlouf Ahmed on 02/01/2024.
//

import Foundation
import Combine

class MovieViewModel: ObservableObject{
    
    let networkManager = NetworkingManager()
    @Published var movies : [Movie] = []

    @Published var searchTerm: String = ""
    @Published var state: FetchState = .good
    
    let defaultLimits = 50

    
    var cancellables = Set<AnyCancellable>()


//    let limit = 20
//    var page  = 0
    
    
    init(){
        $searchTerm
            .removeDuplicates()
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
                self?.state = .good
                self?.movies = []
                self?.fetchMovies(for: term)
            }
            .store(in: &cancellables)
        
    }
    
    
    func fetchMovies(for term: String){
        guard !searchTerm.isEmpty else{
            return
        }
      
        guard state == FetchState.good else {
            return
        }
        state = .isLoading

        networkManager.fetchMovies(searchTerm: searchTerm)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: {[weak self] completion in
                    self?.networkManager.handleCompletion(completion)
                }, receiveValue: { [weak self] result in
                   // for movie in result.results {
                    self?.movies = result.results//.append(movie)
                    if result.resultCount == self?.defaultLimits {
                        self?.state = .good
                    } else {
                        self?.state = .loadedAll
                    }
                    //}
                   // self?.page += 1
                  //  self?.state = (result.results.count == self?.limit) ? .good : .loadedAll

                })
                .store(in: &cancellables)
        }
    
    func loadMore(){
        fetchMovies(for: searchTerm)
    }
    
    static func mockMovie() -> MovieViewModel{
        let vm = MovieViewModel()
        vm.movies = [Movie.mockMovie()]
        return vm
        
    }
}
