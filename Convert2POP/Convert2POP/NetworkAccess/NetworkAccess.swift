//
//  NetworkAccess.swift
//  Convert2POP
//
//  Created by niv ben-porath on 09/04/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import Foundation

enum NetworkError : Error {
    case networkError
    case responseError
    case InvalidData
}

typealias NetworkCompletion =  (Result<Data,NetworkError>) -> Void

struct NetworkAccess {
    
    private var url : URL
    private var session : URLSession
    
    init(url : URL,session : URLSession = URLSession.shared) {
        self.url = url
        self.session = session
    }
    
    func fetchData(with completion : @escaping NetworkCompletion) {
        let task = session.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                completion(.failure(.networkError))
                return
            }
//            if let _ = error {
//                completion(.failure(.networkError))
//            }
            
            guard let networkResponse = response as? HTTPURLResponse, networkResponse.statusCode == 200 else {
                completion(.failure(.responseError))
                return
            }
            
            guard let recivedData = data else {
                completion(.failure(.InvalidData))
                return
            }
            
            completion(.success(recivedData))
        }
        task.resume()
    }
}

