//
//  DataProvider.swift
//  Convert2POP
//
//  Created by niv ben-porath on 09/04/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import Foundation


//this is the 'main' protocol that a screen (or VM) will ask when they need to get data from the network
protocol DataProviding {
    var networkDataObtainer : NetworkDataObtaining {get}
}

//MARK: - specific data providers
protocol MoviesProviding : DataProviding {
    func getMoviesForPage(page : Int,with completion : @escaping (Result<Movie,Error>) -> Void )
}

protocol MoviePageProviding : DataProviding {
    func getMoviePage(for movieId : String,with completion : @escaping(Result<MoviePage,Error>) -> Void)
}


//MARK: - Data provider implementation
struct DataProvider : DataProviding {
    var networkDataObtainer: NetworkDataObtaining
    
    init(networkDataObtainer: NetworkDataObtaining) {
        self.networkDataObtainer =  networkDataObtainer
    }
}

//MARK: - specific implementations
//these are the specific methods calls
extension DataProvider : MoviesProviding {
    func getMoviesForPage(page: Int, with completion: @escaping (Result<Movie, Error>) -> Void) {
        let moviesEndpoint = Endpoint.popularMovies(atPage: String(page))
        networkDataObtainer.getData(for: moviesEndpoint, with: completion)
    }
}

extension DataProvider : MoviePageProviding {
    func getMoviePage(for movieId: String, with completion: @escaping (Result<MoviePage, Error>) -> Void) {
        let moviePageEndpoint = Endpoint.movie(withId: movieId)
        networkDataObtainer.getData(for: moviePageEndpoint, with: completion)
    }
}

//struct MoviesProvider : DataProviding {
////    var networkDataFlow: NetworkDataObtaining
////
////    init(networkDataFlow: NetworkDataObtaining) {
////        self.networkDataFlow =  networkDataFlow
////    }
//
//    func getMoviesForPage(page: Int, with completion: @escaping (Result<Movie, Error>) -> Void) {
//        let moviesEndpoint = Endpoint.popularMovies(atPage: String(page))
//        networkDataFlow.getData(for: moviesEndpoint, with: completion)
//    }
//}

//protocol MoviesProviding {
//    var networkDataFlow : NetworkDataObtaining {get}
//    func getMoviesForPage(page : Int,with completion : @escaping (Result<Movie,Error>) -> Void )
//}

//protocol MoviePageProviding {
//    var networkDataFlow : NetworkDataObtaining {get}
//    func getMoviePage(for movieId : String,with completion : @escaping(Result<MoviePage,Error>) -> Void)
//}

//struct MoviePageProvider : MoviePageProviding {
//
//    var networkDataFlow: NetworkDataObtaining
//
//    init(networkDataFlow: NetworkDataObtaining) {
//        self.networkDataFlow =  networkDataFlow
//    }
//
//    func getMoviePage(for movieId: String, with completion: @escaping (Result<MoviePage, Error>) -> Void) {
//        let moviePageEndpoint = Endpoint.movie(withId: movieId)
//        networkDataFlow.getData(for: moviePageEndpoint,with: completion)
//    }
//}

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
