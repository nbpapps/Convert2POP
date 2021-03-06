//
//  JsonParser.swift
//  Convert2POP
//
//  Created by niv ben-porath on 09/04/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import Foundation

struct JsonParser {
    
    private var data : Data
    private var decoder : JSONDecoder
    
    init(data : Data,decoder : JSONDecoder = JSONDecoder()) {
        self.data = data
        self.decoder = decoder
    }
    
    func decode<T : Decodable>() -> Result<T,Error>{
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let decodedObject = try decoder.decode(T.self, from: data)
            return .success(decodedObject)
        }
        catch {
            return .failure(error)
        }
    }
}
