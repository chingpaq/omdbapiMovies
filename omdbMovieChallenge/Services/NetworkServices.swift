//
//  NetworkServices.swift
//  omdbMovieChallenge
//
//  Created by *_* on 1/20/21.
//

import Foundation

class NetworkServices {
    public let cache = NSCache<NSString, NSData>()
    public let urlSessionConfig = URLSessionConfiguration.default
    
    private static var sharedInstance: NetworkServices = {
        return NetworkServices()
    }()
    
    class func shared() -> NetworkServices {
        sharedInstance.initialize()
        return sharedInstance
    }
    
    private func initialize(){
        self.urlSessionConfig.httpAdditionalHeaders = [
            AnyHashable("Accept"): "application/json"
        ]
    }
    
    private func createAuthParameters(with parameters:[String:String]) -> Data? {
        guard parameters.count > 0 else {return nil}
        return  parameters.map {"\($0.key)=\($0.value)"}.joined(separator: "&").data(using: .utf8)
    }
    
    public func request(url:String, httpMethod: String, headers:[String:String]?, body: [String:String]?, parameters: [URLQueryItem]?, useSharedSession: Bool = false,cachePolicy: URLRequest.CachePolicy = .reloadRevalidatingCacheData, handler: @escaping (Data?, URLResponse?, Int?, Error?) -> Void){
        
        if var urlComponent = URLComponents(string: url) {
            urlComponent.queryItems = parameters
            var session = URLSession(configuration: urlSessionConfig)
            if useSharedSession {
                session = URLSession.shared
            }
            if let _url = urlComponent.url {
                var request = URLRequest(url: _url)
                request.cachePolicy = cachePolicy
                request.allHTTPHeaderFields = headers
                if let _body = body {
                    request.httpBody = createAuthParameters(with: _body)
                }
                request.httpMethod = httpMethod
                session.dataTask(with: request) { (data, response, error) in
                    let httpResponsStatusCode = (response as? HTTPURLResponse)?.statusCode
                    handler(data, response, httpResponsStatusCode, error)
                    }.resume()
            }else{
                handler(nil, nil, nil, Failure.invalidURL)
            }
        }else{
            handler(nil, nil, nil, Failure.invalidURL)
        }
    }
}

public enum Failure:Error {
    case invalidURL
    case invalidSearchParameters
    case invalidStatusCode(Int?)
    case invalidResults(String)
}

extension Failure: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "")
        case .invalidSearchParameters:
            return NSLocalizedString("Invalid URL parameters", comment: "")
        case .invalidResults(let errorMessage):
            return NSLocalizedString(errorMessage, comment: "")
        case .invalidStatusCode(let errorMessage):
            return NSLocalizedString("Invalid HTTP status code:\(errorMessage ?? -1)", comment: "")
        }
    }
}

