//
//  AllMovieModels.swift
//  Convert2POP
//
//  Created by niv ben-porath on 09/04/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import Foundation

struct Movie : Codable {
    var page : Double
    var totalResults : Double
    var totalPages : Double
    var results : [MovieInfo]
    
}

struct MovieInfo :Codable {
    var title : String
    var id : Int
}

struct MoviePage : Codable {
    var overview : String
}
