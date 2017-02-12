//
//  ViewController.swift
//  brws-mv
//
//  Created by Dunya Kirkali on 2/10/17.
//  Copyright © 2017 Dunya Kirkali. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    var selectedRow: MovieCellTableViewCell!

    var movies = [Movie]()
    let tableCellIdentifier = "MovieCell"
    let placeholderCellIdentifier = "PlaceholderCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "MovieCellTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        tableView.register(UINib(nibName: "PlaceholderTableViewCell", bundle: nil), forCellReuseIdentifier: placeholderCellIdentifier)
        
        Client.sharedInstance.configure()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if movies.count == 0 {
            return 1
        } else {
            return movies.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        if movies.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: placeholderCellIdentifier, for: indexPath) as! PlaceholderTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: tableCellIdentifier, for: indexPath) as! MovieCellTableViewCell
            cell.movieName?.text = movies[row].title
            cell.backgroundImage?.image = movies[row].image
            return cell
        }
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let destinationVC = DetailViewController()
//        destinationVC.movie = movies[row]
        self.performSegue(withIdentifier: "toMovieDetails", sender: self)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if movies.count == 0 {
            return
        }
        selectedRow = tableView.cellForRow(at: indexPath) as! MovieCellTableViewCell        
        tableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.top, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if movies.count == 0 {
            return tableView.frame.size.height
        } else {
            return tableView.frame.size.height / 3.0;
        }
    }
    
    func searchFor(title: String) {
        movies = Client.sharedInstance.searchFor(title: title)
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchFor(title: searchBar.text!)
        self.view.endEditing(true)
    }
}

