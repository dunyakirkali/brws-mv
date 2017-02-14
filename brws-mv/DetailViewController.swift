//
//  DetailViewViewController.swift
//  brws-mv
//
//  Created by Dunya Kirkali on 2/11/17.
//  Copyright © 2017 Dunya Kirkali. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var plot: UILabel!
    
    var movie : Movie?
    
    let gotMovieNotificationName = Notification.Name("gotMovie")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.populateMovieDetails(_:)), name: gotMovieNotificationName, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleLabel.text = movie?.title
        Client.sharedInstance.get(imdbId: movie!.imdbID)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(sender: UIButton) {
        self.performSegue(withIdentifier: "toMoviesIndex", sender: self)
    }

    func populateMovieDetails(_ notification: NSNotification) {
        print("populateMovieDetails")
        let newMovie = notification.object as? Movie
        print(notification.object)
        print(newMovie!.year)
        print(newMovie!.genre)
        plot.text = movie?.plot
    }
}
