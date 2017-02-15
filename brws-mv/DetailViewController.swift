//
//  DetailViewViewController.swift
//  brws-mv
//
//  Created by Dunya Kirkali on 2/11/17.
//  Copyright © 2017 Dunya Kirkali. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var plot: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var director: UILabel!
    @IBOutlet weak var actors: UILabel!
    
    var movie : Movie?
    
    let gotMovieNotificationName = Notification.Name("gotMovie")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.populateMovieDetails(_:)), name: gotMovieNotificationName, object: nil)
        
        title = movie?.title
        
        Client.sharedInstance.get(imdbId: movie!.imdbID)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func populateMovieDetails(_ notification: NSNotification) {
        movie = notification.object as? Movie
        plot.text = movie?.plot
        plot.sizeToFit()
        director.text = movie?.director
        actors.text = movie?.actors
        genre.text = movie?.genre
        if movie?.poster != "N/A" {
            let url = URL(string: movie!.poster)
            let data = try? Data(contentsOf: url!)
            image.image = UIImage(data: data!)
        } else {
            image.image = UIImage(named: "placeholder.jpg")
        }
    }
}
