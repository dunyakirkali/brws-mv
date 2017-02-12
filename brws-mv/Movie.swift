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
    var poster: UIImage!

    init(title: String, year: String, genre: String, director: String, plot: String, poster: UIImage) {
        self.title = title
        self.year = year
        self.genre = genre
        self.director = director
        self.plot = plot
        self.poster = poster
    }

}
