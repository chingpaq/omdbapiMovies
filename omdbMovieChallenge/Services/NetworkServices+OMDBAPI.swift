//
//  NetworkServices+OMDBAPI.swift
//  omdbMovieChallenge
//
//  Created by *_* on 1/20/21.
//

import Foundation

extension NetworkServices {
    func searchMovies(for name: String, page: Int = 1, handler: @escaping(MoviesModel.List?, Error?) -> Void){
        var queries = [URLQueryItem]()
        queries.append(URLQueryItem(name: "s", value: name))
        queries.append(URLQueryItem(name: "page", value: String(page)))
        queries.append(URLQueryItem(name: "r", value: "json"))
        queries.append(URLQueryItem(name: "apiKey", value: OMDBAPIServices.SearchMovies.omdbAPIKey))
        
        request(url: OMDBAPIServices.SearchMovies.url, httpMethod: "get", headers: nil, body: nil, parameters: queries){
            (data, response, status, error)  in
            if let _data = data, status == 200 {
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(MoviesModel.List.self, from: _data)
                    handler(result, nil)
                } catch let error {
                    handler(nil, error)
                }
            }else{
                handler(nil, Failure.invalidStatusCode(status))
            }
        }
    }
    
    func searchMovie(with imdbID: String, handler: @escaping(MoviesModel.Movie?, Error?) -> Void){
        var queries = [URLQueryItem]()
        queries.append(URLQueryItem(name: "i", value: imdbID))
        queries.append(URLQueryItem(name: "r", value: "json"))
        queries.append(URLQueryItem(name: "apiKey", value: OMDBAPIServices.SearchMovies.omdbAPIKey))
        
        request(url: OMDBAPIServices.SearchMovies.url, httpMethod: "get", headers: nil, body: nil, parameters: queries){
            (data, response, status, error)  in
            if let _data = data, status == 200 {
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(MoviesModel.Movie.self, from: _data)
                    handler(result, nil)
                } catch let error {
                    handler(nil, error)
                }
            }else{
                handler(nil, Failure.invalidStatusCode(status))
            }
        }
    }
    
    func getImage(url: String, handler: @escaping(Data?, Error?) -> Void){
        let cacheID = NSString(string: url)
        
        if let cachedData = cache.object(forKey: cacheID) {
            handler((cachedData as Data), nil)
        }else{
            if let url = URL(string: url) {
                let session = URLSession(configuration: urlSessionConfig)
                var request = URLRequest(url: url)
                request.cachePolicy = .returnCacheDataElseLoad
                request.httpMethod = "get"
                session.dataTask(with: request) { (data, response, error) in
                    if let _data = data {
                        self.cache.setObject(_data as NSData, forKey: cacheID)
                        handler(_data, nil)
                    }else{
                        handler(nil, error)
                    }
                    }.resume()
            } else {
                handler(nil, Failure.invalidURL)
            }
        }
        
    }
}
