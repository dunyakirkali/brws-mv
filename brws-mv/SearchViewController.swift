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
    let gotMoviesNotificationName = Notification.Name("gotMovies")
    let endGetNotificationName = Notification.Name("endGet")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "MovieCellTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        tableView.register(UINib(nibName: "PlaceholderTableViewCell", bundle: nil), forCellReuseIdentifier: placeholderCellIdentifier)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.populateMovies(_:)), name: gotMoviesNotificationName, object: nil)
        
        title = "Movies"
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
            if movies[row].poster != "N/A" {
                let url = URL(string: movies[row].poster)
                let data = try? Data(contentsOf: url!)
                cell.backgroundImage?.image = UIImage(data: data!)
            } else {
                cell.backgroundImage?.image = UIImage(named: "placeholder.jpg")
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if movies.count == 0 {
            return
        }
        selectedRow = tableView.cellForRow(at: indexPath) as! MovieCellTableViewCell
        tableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.top, animated: true)
        self.performSegue(withIdentifier: "toMovieDetails", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if movies.count == 0 {
            return tableView.frame.size.height
        } else {
            return 200;
        }
    }
    
    func searchFor(title: String) {
        Client.sharedInstance.searchFor(title: title)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchFor(title: searchBar.text!)
        self.view.endEditing(true)
    }
    
    func populateMovies(_ notification: NSNotification) {
        movies = notification.object as! [Movie]
        if movies.count == 0 {
            NotificationCenter.default.post(name: self.endGetNotificationName, object: nil)
        }
        self.reloadDataWithAnimation()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let movie = movies[tableView.indexPathForSelectedRow!.row]
        let destinationVC = segue.destination as! DetailViewController
        print(movie.imdbID)
        destinationVC.movie = movie
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            movies = []
            NotificationCenter.default.post(name: self.endGetNotificationName, object: nil)
            self.reloadDataWithAnimation()
        }
    }
    
    func reloadDataWithAnimation() {
        let range = NSMakeRange(0, self.tableView.numberOfSections)
        let sections = NSIndexSet(indexesIn: range)
        tableView.reloadSections(sections as IndexSet, with: .automatic)
    }
}

