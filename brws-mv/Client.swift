//
//  Client.swift
//  brws-mv
//
//  Created by Dunya Kirkali on 2/12/17.
//  Copyright © 2017 Dunya Kirkali. All rights reserved.
//

import UIKit
import RestKit
import Reachability

class Client: NSObject {
    static let sharedInstance = Client()
    
    let kBaseURL:String = "https://www.omdbapi.com/"
    let alertNotificationName = Notification.Name("alert")
    let gotMoviesNotificationName = Notification.Name("gotMovies")
    let gotMovieNotificationName = Notification.Name("gotMovie")
    let endGetNotificationName = Notification.Name("endGet")
    let startGetNotificationName = Notification.Name("startGet")
    
    var objectManager:RKObjectManager
    var reachable:Bool
    var reach: Reachability?
    
    override init() {
        self.objectManager = RKObjectManager(baseURL: URL(string: kBaseURL)!)
        self.reachable = false
        self.reach = Reachability.forInternetConnection()
        self.reach!.reachableOnWWAN = true
        self.reach!.startNotifier()
        self.reachable = self.reach!.isReachable()
    }
    
    func configure() {
        let movieMapping: RKObjectMapping = RKObjectMapping(for: Movie.self)
        movieMapping.addAttributeMappings(from: ["Title": "title", "Year": "year", "Poster": "poster", "imdbID": "imdbID", "Plot": "plot", "Genre": "genre", "Director": "director", "Actors": "actors"])
        let statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClass.successful)
        let resDescriptor = RKResponseDescriptor(mapping: movieMapping, method: RKRequestMethod.GET, pathPattern:nil, keyPath: "Search", statusCodes: statusCodes)
        let resDescriptorTwo = RKResponseDescriptor(mapping: movieMapping, method: RKRequestMethod.GET, pathPattern:nil, keyPath: nil, statusCodes: statusCodes)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged), name: NSNotification.Name.reachabilityChanged, object: nil)
        
        objectManager.addResponseDescriptor(resDescriptor)
        objectManager.addResponseDescriptor(resDescriptorTwo)
    }
    
    func searchFor(title: String) {
        if !reachable {
            NotificationCenter.default.post(name: alertNotificationName, object: nil)
            return;
        }
        
        NotificationCenter.default.post(name: startGetNotificationName, object: nil)
        
        let params: [String: String] = [
            "s" : title,
            "r" : "json"
        ]
        
        objectManager.getObjectsAtPath("/", parameters: params, success: { (operation, mappingResult) -> Void in
            let results = mappingResult?.array()
            NotificationCenter.default.post(name: self.gotMoviesNotificationName, object: results)
            
        }) { (operation, error) -> Void in
            print(error!.localizedDescription)
            NotificationCenter.default.post(name: self.endGetNotificationName, object: nil)
        }
    }
    
    func get(imdbId: String) {
        if !reachable {
            NotificationCenter.default.post(name: alertNotificationName, object: nil)
            return;
        }
        
        NotificationCenter.default.post(name: startGetNotificationName, object: nil)
        
        let params: [String: String] = [
            "i" : imdbId,
            "r" : "json"
        ]
        
        objectManager.getObjectsAtPath("/", parameters: params, success: { (operation, mappingResult) -> Void in
            let result = mappingResult?.firstObject as! Movie
            NotificationCenter.default.post(name: self.gotMovieNotificationName, object: result)
            
        }) { (operation, error) -> Void in
            print(error!.localizedDescription)
            NotificationCenter.default.post(name: self.endGetNotificationName, object: nil)
        }
    }
    
    
    func reachabilityChanged(notification: NSNotification) {
        self.reachable = self.reach!.isReachableViaWiFi() || self.reach!.isReachableViaWWAN()
    }
}
