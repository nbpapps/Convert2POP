//
//  DataProvider.swift
//  Convert2POP
//
//  Created by niv ben-porath on 09/04/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import Foundation


protocol MoviesProviding {
    var networkDataFlow : NetworkDataObtaining {get}
    func getMoviesForPage(page : Int,with completion : @escaping (Result<Movie,Error>) -> Void )
}


struct MoviesProvider : MoviesProviding {
    var networkDataFlow: NetworkDataObtaining

    init(networkDataFlow: NetworkDataObtaining) {
        self.networkDataFlow =  networkDataFlow
    }

    func getMoviesForPage(page: Int, with completion: @escaping (Result<Movie, Error>) -> Void) {
        let moviesEndpoint = Endpoint.popularMovies(atPage: String(page))
        networkDataFlow.getData(for: moviesEndpoint, with: completion)
    }
}



protocol MoviePageProviding {
    var networkDataFlow : NetworkDataObtaining {get}
    func getMoviePage(for movieId : String,with completion : @escaping(Result<MoviePage,Error>) -> Void)
}

struct MoviePageProvider : MoviePageProviding {
    
    var networkDataFlow: NetworkDataObtaining

    init(networkDataFlow: NetworkDataObtaining) {
        self.networkDataFlow =  networkDataFlow
    }
 
    func getMoviePage(for movieId: String, with completion: @escaping (Result<MoviePage, Error>) -> Void) {
        let moviePageEndpoint = Endpoint.movie(withId: movieId)
        networkDataFlow.getData(for: moviePageEndpoint,with: completion)
    }
}

//class DataProvider {
//
//    private let networkDataFlow = NetworkDataFlow()
    
//    func getMoviesForPage<T:Decodable>(page : Int, with completion : @escaping (Result<T,Error>) -> Void) {
//        let moviesEndpoint = Endpoint.popularMovies(atPage: String(page))
//        networkDataFlow.getData(for: moviesEndpoint.endpointURL) { (result : Result<T,Error>) in
//            completion(result)
//        }
//    }
    
//    func getMoviePage<T:Decodable>(for movieId : String, with completion : @escaping (Result<T,Error>) -> Void) {
//        let moviePageEndpoint = Endpoint.movie(withId: movieId)
//        networkDataFlow.getData(for: moviePageEndpoint.endpointURL) { (result : Result<T,Error>) in
//            completion(result)
//        }
//    }
//}
