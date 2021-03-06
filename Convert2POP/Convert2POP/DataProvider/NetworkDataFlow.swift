//
//  NetworkDataFlow.swift
//  Convert2POP
//
//  Created by niv ben-porath on 09/04/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import Foundation

class NetworkDataFlow {
    
    //MARK: - This method is in charge of the flow - getting data from the network and parsing it into model data
    public func getData<T:Decodable>(for url: URL, with completion: @escaping (Result<T, Error>) -> Void) {
        fetchNetworkData(at: url) {[weak self] (networkResult : Result<Data,Error>) in
            guard let self = self else {return}
            switch networkResult {
                
            case .success(let data):
                self.parseNetworkData(data: data) { (parserResult : Result<T,Error>) in
                    DispatchQueue.main.async {
                        switch parserResult {
                        case .success(let items):
                            completion(.success(items))
                        case .failure(let error):
                            completion(.failure(error)) // parser error
                        }
                    }
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error)) //network fail
                }
            }
        }
    }
    
    //MARK: - get the data form the network
    private func fetchNetworkData(at url : URL, with completion : @escaping (Result<Data,Error>) -> Void) {
        let networkAccess = NetworkAccess(url: url)
        networkAccess.fetchData() {(result) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //MARK: - parse the data
    private func parseNetworkData<T:Decodable>(data : Data,with completion : @escaping (Result<T,Error>) -> Void){
        let jsonParser = JsonParser(data: data)
        let reslut : Result<T,Error> = jsonParser.decode()
        completion(reslut)
    }
}
