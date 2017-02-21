//
//  Movie.swift
//  brws-mv
//
//  Created by Dunya Kirkali on 2/11/17.
//  Copyright © 2017 Dunya Kirkali. All rights reserved.
//

import UIKit
import ObjectMapper

class Movie: NSObject, Mappable {

    var title: String
    var year: String
    var genre: String
    var director: String
    var actors: String
    var plot: String
    var poster: String
    var imdbID: String
    
    required init?(map: Map) {
        self.title = ""
        self.year = ""
        self.genre = ""
        self.director = ""
        self.actors = ""
        self.plot = ""
        self.poster = ""
        self.imdbID = ""
    }
    
    // Mappable
    func mapping(map: Map) {
        title      <- map["Title"]
        year       <- map["Year"]
        genre      <- map["Genre"]
        director   <- map["Director"]
        actors     <- map["Actors"]
        plot       <- map["Plot"]
        poster     <- map["Poster"]
        imdbID     <- map["imdbID"]
    }
}
