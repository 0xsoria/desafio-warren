//
//  File.swift
//  
//
//  Created by Gabriel Soria Souza on 09/03/21.
//

import CoreProviders
import Foundation

final class NetworkMock: NetworkServiceable {
    func request(model: NetworkDataModel, completion: @escaping ((Result<Data, NetworkError>) -> Void)) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            let dataFromJSONString = portifolio.data(using: .utf8)
            guard let returnData = dataFromJSONString else {
                completion(.failure(.invalidJSON))
                return
            }
            completion(.success(returnData))
        })
    }
}
