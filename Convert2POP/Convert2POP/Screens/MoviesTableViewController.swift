//
//  MoviesTableViewController.swift
//  Convert2POP
//
//  Created by niv ben-porath on 09/04/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import UIKit

class MoviesTableViewController: UITableViewController {
    
    let dataProvider : DataProvider
    var movies = [MovieInfo]()
    
    //MARK: - inits
    init(dataProvider : DataProvider) {
        self.dataProvider = dataProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        loadMovies(forPage: 1)
    }
    
    //MARK: - load data
    private func loadMovies(forPage page : Int) {
        dataProvider.getMoviesForPage(page: page){ [weak self] (moviesResult : Result<Movie,Error>) in
            guard let self = self else {return}
            switch moviesResult {
            case .success(let movies):
                self.movies = movies.results
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let movie = movies[indexPath.row]
        cell.textLabel?.text = movie.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        let movieId = String(movie.id)
        dataProvider.getMoviePage(for: movieId) { (movie : Result<MoviePage,Error>) in
            print(movie)
        }
    }
    
}
