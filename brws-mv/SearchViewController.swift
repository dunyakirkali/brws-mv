//
//  ViewController.swift
//  brws-mv
//
//  Created by Dunya Kirkali on 2/10/17.
//  Copyright © 2017 Dunya Kirkali. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!

    let movies = [
        Movie.init(title: "Terminator", image: UIImage(named: "eyes.jpg")!),
        Movie.init(title: "Matrix", image: UIImage(named: "twinpeaks.png")!),
        Movie.init(title: "Cloud Atlas", image: UIImage(named: "matrix.png")!),
        Movie.init(title: "Harry Potter", image: UIImage(named: "eyes.jpg")!),
        Movie.init(title: "Waterworld", image: UIImage(named: "eyes.jpg")!)
    ]
    let tableCellIdentifier = "MovieCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.register(UINib(nibName: "MovieCellTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellIdentifier, for: indexPath) as! MovieCellTableViewCell
        let row = indexPath.row
        cell.movieName?.text = movies[row].title
        cell.backgroundImage?.image = movies[row].image
        return cell
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let destinationVC = DetailViewController()
//        destinationVC.movie = movies[row]
        self.performSegue(withIdentifier: "toMovieDetails", sender: self)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)        
        tableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.top, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.height / 3.0;
    }
}

