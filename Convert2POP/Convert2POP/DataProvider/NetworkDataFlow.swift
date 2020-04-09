//
//  NetworkDataFlow.swift
//  Convert2POP
//
//  Created by niv ben-porath on 09/04/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import Foundation




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
