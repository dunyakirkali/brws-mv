//
//  Movie.swift
//  brws-mv
//
//  Created by Dunya Kirkali on 2/11/17.
//  Copyright © 2017 Dunya Kirkali. All rights reserved.
//

import UIKit

class Movie: NSObject {

    var title: String
    var year: String
    var genre: String
    var director: String
    var plot: String
    var poster: String
    
    override init() {
        self.title = ""
        self.year = ""
        self.genre = ""
        self.director = ""
        self.plot = ""
        self.poster = ""
    }
}
