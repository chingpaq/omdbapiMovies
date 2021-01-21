//
//  MovieTableViewController.swift
//  omdbMovieChallenge
//
//  Created by *_* on 1/20/21.
//
import UIKit


class MovieTableViewController: UITableViewController{
    private let searchController = UISearchController(searchResultsController: nil)
    private let networkService = NetworkServices.shared()
    private var movies = [MoviesModel.List.Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = LILocalizedString("App_Title", comment: "OMDB Movie Challenge")
        searchController.searchBar.placeholder = LILocalizedString("Search_PlaceholderText", comment: "Type Movie Title")
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        navigationItem.searchController = searchController
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        // FIXME: - remove if starting from a blank table
        self.movies = MoviesModel.stubbedMoviesList
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MovieTableViewCell {
            cell.configureCell(with: movies[indexPath.row])
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "displayMovieSegue", sender: movies[indexPath.row].imdbID)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "displayMovieSegue" {
            if let viewController = segue.destination as? DetailViewController, let id = sender as? String {
                viewController.imdbID = id
            }
        }
    }
    
    func search(for movieName: String, page: Int, handler: @escaping ((Bool, Error?) -> Void)) {
        networkService.searchMovies(for: movieName, page: page) { (searchObject, error) in
            if let _ = searchObject, error == nil {
                if let searchReasults = searchObject?.results {
                    self.movies = searchReasults
                    DispatchQueue.main.async {
                        self.tableView.backgroundView = UIView()
                        self.tableView.reloadData()
                    }
                }else{
                    DispatchQueue.main.async {
                        self.movies.removeAll()
                        self.tableView.reloadData()
                    }
                }
                handler(true, nil)
            }else{
                handler(false, error)
            }
        }
    }
}
 
extension MovieTableViewController: UISearchResultsUpdating {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search(for: searchBar.text ?? "", page: 1) {[weak self] (done, error) in
            // TODO - A search for a movie may return several rows and they are divided into pages as indicated in the OMDB data (). This function only reads the 1st page
            if !done {
                self?.showAlert(title: LILocalizedString("Search_Failure", comment: "Search failed!"), alertMessage: error?.localizedDescription ?? "Error")
            }
        }
    }
    func updateSearchResults(for searchController: UISearchController) {
        if let movieSearched = searchController.searchBar.text {
            guard movieSearched.count > 2 else {return}
        }
    }
}
extension MovieTableViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar,
      selectedScopeButtonIndexDidChange selectedScope: Int) {
  }
}
