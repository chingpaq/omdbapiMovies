//
//  MovieModel+Stub.swift
//  omdbMovieChallenge
//
//  Created by *_* on 1/20/21.
//

import Foundation

extension MoviesModel {
    
    static var stubbedMoviesList: [MoviesModel.List.Movie] {
        let response: MoviesModel.List? = try? Bundle.main.loadAndDecodeJSON(filename: "MoviesList")
        return response!.results!
    }

    static var stubbedMovie: MoviesModel.List.Movie {
        stubbedMoviesList[0]
    }
    
}

extension Bundle {
    func loadAndDecodeJSON<D: Decodable>(filename: String) throws -> D? {
        guard let url = self.url(forResource: filename, withExtension: "json") else {
            return nil
        }
        let data = try Data(contentsOf: url)
        let jsonDecoder = JSONDecoder()
        let decodedModel = try jsonDecoder.decode(D.self, from: data)
        return decodedModel
    }
}
