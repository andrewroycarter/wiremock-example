//
//  API.swift
//  Reddit
//
//  Created by Andrew Carter on 8/30/19.
//  Copyright © 2019 AshleyCo. All rights reserved.
//

import Foundation

enum APIError: Error {
    case missingData
}

class API: NSObject, URLSessionDelegate {
    
    private lazy var session: URLSession = {
        return URLSession(configuration: .default, delegate: self, delegateQueue: nil)
    }()
    
    func perform<T: Decodable>(request: URLRequest, completionHandler: @escaping (Result<T, Error>) -> Void) {
        let task = session.dataTask(with: request) { (data, respnose, error) in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(APIError.missingData))
                return
            }
            
            let result = Result<T, Error>(catching: { () -> T in
                return try JSONDecoder().decode(T.self, from: data)
            })
            
            completionHandler(result)
        }
        
        task.resume()
    }
    
    #if DEBUG
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if challenge.protectionSpace.host == "127.0.0.1",
            let trust = challenge.protectionSpace.serverTrust {
            completionHandler(.useCredential, URLCredential(trust: trust))
        } else {
            completionHandler(.performDefaultHandling, nil)
        }
    }
    #endif
    
}
