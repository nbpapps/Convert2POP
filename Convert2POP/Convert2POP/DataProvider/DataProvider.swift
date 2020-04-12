//
//  DataProvider.swift
//  Convert2POP
//
//  Created by niv ben-porath on 09/04/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import Foundation

class DataProvider {
    
    private let networkDataFlow = NetworkDataFlow()
    
    func getMoviesForPage<T:Decodable>(page : Int, with completion : @escaping (Result<T,Error>) -> Void) {
        let moviesEndpoint = Endpoint.popularMovies(atPage: String(page))
        networkDataFlow.getData(for: moviesEndpoint.endpointURL) { (result : Result<T,Error>) in
            completion(result)
        }
    }
    
    func getMoviePage<T:Decodable>(for movieId : String, with completion : @escaping (Result<T,Error>) -> Void) {
        let moviePageEndpoint = Endpoint.movie(withId: movieId)
        networkDataFlow.getData(for: moviePageEndpoint.endpointURL) { (result : Result<T,Error>) in
            completion(result)
        }
    }
}
