//
//  Client.swift
//  brws-mv
//
//  Created by Dunya Kirkali on 2/12/17.
//  Copyright © 2017 Dunya Kirkali. All rights reserved.
//

import UIKit
import Reachability

class Client: NSObject {
    static let sharedInstance = Client()
    
    let kBaseURL:String = "https://www.omdbapi.com/"
    let alertNotificationName = Notification.Name("alert")
    let gotMoviesNotificationName = Notification.Name("gotMovies")
    let gotMovieNotificationName = Notification.Name("gotMovie")
    let endGetNotificationName = Notification.Name("endGet")
    let startGetNotificationName = Notification.Name("startGet")
    
    var reachable:Bool
    var reach: Reachability?
    
    override init() {
        self.reachable = false
        self.reach = Reachability.forInternetConnection()
        self.reach!.reachableOnWWAN = true
        self.reach!.startNotifier()
        self.reachable = self.reach!.isReachable()
    }
    
    func configure() {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged), name: NSNotification.Name.reachabilityChanged, object: nil)
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
    }
    
    
    func reachabilityChanged(notification: NSNotification) {
        self.reachable = self.reach!.isReachableViaWiFi() || self.reach!.isReachableViaWWAN()
    }
}
