//
//  OMDBAPIServices.swift
//  omdbMovieChallenge
//
//  Created by *_* on 1/20/21.
//

import Foundation

enum OMDBAPIServices {
    case SearchMovies
}

extension OMDBAPIServices {
    var omdbAPIKey:String {
     return "f70944e2"
    }
    
    var url:String {
        let omdbAPIURL = "http://www.omdbapi.com"
        switch(self){
        case .SearchMovies:
            return "\(omdbAPIURL)/?"
        }
    }
}
