//
//  Client.swift
//  brws-mv
//
//  Created by Dunya Kirkali on 2/12/17.
//  Copyright © 2017 Dunya Kirkali. All rights reserved.
//

import UIKit

class Client: NSObject {
    static let sharedInstance = Client()
    
    func configure() {
        print("Configure")
    }
    
    func searchFor(title: String) -> [Movie] {
        var results = [Movie]()
        if title != "" {
            results = [
                Movie.init(title: "Terminator", image: UIImage(named: "eyes.jpg")!),
                Movie.init(title: "Matrix", image: UIImage(named: "twinpeaks.png")!),
                Movie.init(title: "Cloud Atlas", image: UIImage(named: "matrix.png")!),
                Movie.init(title: "Harry Potter", image: UIImage(named: "placeholder.png")!),
                Movie.init(title: "Waterworld", image: UIImage(named: "placeholder.jpg")!)
            ]
        }
        return results
    }
}
