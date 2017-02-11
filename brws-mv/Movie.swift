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
    var image: UIImage!
    
    init(title: String, image: UIImage) {
        self.title = title
        self.image = image
    }

}
