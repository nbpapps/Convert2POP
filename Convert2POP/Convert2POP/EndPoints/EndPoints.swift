//
//  EndPoints.swift
//  Convert2POP
//
//  Created by niv ben-porath on 09/04/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import Foundation

struct Endpoint {
    private var path: String
    private var queryItems: [URLQueryItem] = []
}

//https://api.themoviedb.org/3/movie/popular?api_key=4258adb04e249b52c4d9dba2586f9c8a&language=en-US&page=1

extension Endpoint  {
    var endPointURL: URL {
        
        let defaultQueryItems = [URLQueryItem(name: "api_key", value: "4258adb04e249b52c4d9dba2586f9c8a"),URLQueryItem(name: "language", value: "en-US")]
        
        var components = URLComponents()
        components.scheme = "https"
        components.host =  "api.themoviedb.org"
        components.path = "/" + path
        components.queryItems = queryItems + defaultQueryItems
        
        guard let url = components.url else {
            preconditionFailure(
                "Invalid URL components: \(components)"
            )
        }
        
        return url
    }
}

extension Endpoint {
    static func popularMovies(atPage page : String) -> Self {
        let pageQueryItem = URLQueryItem(name: "page", value: page)
        return Endpoint(path: "3/movie/popular", queryItems: [pageQueryItem])
    }
    
    static func movie(withId id : String) -> Self {
        Endpoint(path: "3/movie/\(id)")
    }
}
