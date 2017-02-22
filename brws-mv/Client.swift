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
        let session = URLSession.shared
        let url = URL(string: kBaseURL + "?s=\(title)&r='json'")
        let request = NSMutableURLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 1)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request as URLRequest) {data,response,error in
            let httpResponse = response as? HTTPURLResponse
            if (error != nil || httpResponse?.statusCode != 200) {
                NotificationCenter.default.post(name: self.endGetNotificationName, object: nil)
            } else {
                let inJsonString = String(data: data!, encoding: String.Encoding.utf8)
                let decoded = try? JSONSerialization.jsonObject(with: (inJsonString?.data(using: String.Encoding.utf8))!, options: [])
                let dictFromJSON = decoded as? [String:Any]
                var movies = [Movie]()
                let items = dictFromJSON?["Search"] as! [Any]
                for movieJson in items {
                    let jsonData = try? JSONSerialization.data(withJSONObject: movieJson, options: .prettyPrinted)
                    let jsonString = NSString(data: jsonData!, encoding: String.Encoding.utf8.rawValue)! as String
                    let movie = Movie(JSONString: jsonString)
                    movies.append(movie!)
                }
                DispatchQueue.main.sync(execute: {
                    NotificationCenter.default.post(name: self.gotMoviesNotificationName, object: movies)
                })
                
            }
        }
        task.resume()
    }
    
    func get(imdbId: String) {
        if !reachable {
            NotificationCenter.default.post(name: alertNotificationName, object: nil)
            return;
        }
        
        NotificationCenter.default.post(name: startGetNotificationName, object: nil)
        let session = URLSession.shared
        let url = URL(string: kBaseURL + "?i=\(imdbId)&r='json'")
        let request = NSMutableURLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 1)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request as URLRequest) {data,response,error in
            let httpResponse = response as? HTTPURLResponse
            if (error != nil || httpResponse?.statusCode != 200) {
                NotificationCenter.default.post(name: self.endGetNotificationName, object: nil)
            } else {
                let jsonString = String(data: data!, encoding: String.Encoding.utf8)
                let movie = Movie(JSONString: jsonString!)
                
                DispatchQueue.main.sync(execute: {
                    NotificationCenter.default.post(name: self.gotMovieNotificationName, object: movie)
                })
                
            }
        }
        task.resume()
    }
    
    
    func reachabilityChanged(notification: NSNotification) {
        self.reachable = self.reach!.isReachableViaWiFi() || self.reach!.isReachableViaWWAN()
    }
}
