//
//  MovieModel.swift
//  omdbMovieChallenge
//
//  Created by *_* on 1/20/21.
//

import Foundation

struct MoviesModel {
    struct Movie: Codable {
        let title: String
        let year: String
        let rated: String
        let released: String
        let runtime: String
        let genre: String
        let director: String
        let writer: String
        let actors: String
        let plot: String
        let language: String
        let country: String
        let awards: String
        let poster: String
        let metascore: String
        let imdbRating: String
        let imdbVotes: String
        let imdbID: String
        let type: String
        let boxOffice: String
        let production: String
        let response: String
        
        private enum CodingKeys: String, CodingKey {
            case title = "Title"
            case year = "Year"
            case rated = "Rated"
            case released = "Released"
            case runtime = "Runtime"
            case genre = "Genre"
            case director = "Director"
            case writer = "Writer"
            case actors = "Actors"
            case plot = "Plot"
            case language = "Language"
            case country = "Country"
            case awards = "Awards"
            case poster = "Poster"
            case metascore = "Metascore"
            case imdbRating
            case imdbVotes
            case imdbID
            case type = "Type"
            case boxOffice = "BoxOffice"
            case production = "Production"
            case response = "Response"
        }
    }
    struct List: Codable {
        let results: [Movie]?
        let totalResults: String?
        let response: String
        let error: String?
        
        private enum CodingKeys: String, CodingKey {
            case results = "Search"
            case totalResults
            case response = "Response"
            case error = "Error"
        }
        struct Movie: Codable {
            let title: String
            let year: String
            let imdbID: String
            let type: String
            let poster: String
      
            private enum CodingKeys: String, CodingKey {
                case title = "Title"
                case year = "Year"
                case imdbID
                case type = "Type"
                case poster = "Poster"
            }
        }
    }
}
