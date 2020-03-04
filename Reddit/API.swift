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

class API {
    
    private let session = URLSession(configuration: .default)
    
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
    
}
