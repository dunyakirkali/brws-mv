//
//  Client.swift
//  brws-mv
//
//  Created by Dunya Kirkali on 2/12/17.
//  Copyright © 2017 Dunya Kirkali. All rights reserved.
//

import UIKit
import RestKit

class Client: NSObject {
    static let sharedInstance = Client()
    let kBaseURL:String = "https://www.omdbapi.com/"
    let endGetNotificationName = Notification.Name("endGet")
    let startGetNotificationName = Notification.Name("startGet")
    var objectManager:RKObjectManager
    
    override init() {
        self.objectManager = RKObjectManager(baseURL: URL(string: kBaseURL)!)
    }
    
    func configure() {
        print("Configure")
        let movieMapping: RKObjectMapping = RKObjectMapping(for: Movie.self)
        movieMapping.addAttributeMappings(from: ["title", "year", "genre", "director", "plot", "poster"])
        let statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClass.successful)
        let resDescriptor = RKResponseDescriptor(mapping: movieMapping, method: RKRequestMethod.GET, pathPattern:"/", keyPath: nil, statusCodes: statusCodes)
        
        objectManager.addResponseDescriptor(resDescriptor)
    }
    
    func searchFor(title: String) -> [Movie] {
        NotificationCenter.default.post(name: startGetNotificationName, object: nil)
        
        let params: [String: String] = [
            "t" : "Matrix",
            "r" : "json"
        ]
        
        objectManager.getObjectsAtPath("/", parameters: params, success: { (operation, mappingResult) -> Void in
            
            let movie: Movie = mappingResult?.firstObject as! Movie
            
            print("ID: \(movie.genre)")
            NotificationCenter.default.post(name: self.endGetNotificationName, object: nil)
            
        }) { (operation, error) -> Void in
            print(error!.localizedDescription)
            NotificationCenter.default.post(name: self.endGetNotificationName, object: nil)
        }

        var results = [Movie]()
        if title != "" {
            results = [
//                Movie.init(title: "Terminator", image: UIImage(named: "eyes.jpg")!),
//                Movie.init(title: "Matrix", image: UIImage(named: "twinpeaks.png")!),
//                Movie.init(title: "Cloud Atlas", image: UIImage(named: "matrix.png")!),
//                Movie.init(title: "Harry Potter", image: UIImage(named: "placeholder.png")!),
//                Movie.init(title: "Waterworld", image: UIImage(named: "placeholder.jpg")!)
            ]
        }
        return results
    }
}
