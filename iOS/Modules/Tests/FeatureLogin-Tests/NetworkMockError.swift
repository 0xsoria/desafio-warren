//
//  File.swift
//  
//
//  Created by Gabriel Soria Souza on 05/03/21.
//

import CoreProviders
import Foundation

final class NetworkMockError: NetworkServiceable {
    func request(model: NetworkDataModel, completion: @escaping ((Result<Data, NetworkError>) -> Void)) {
        completion(.failure(.noResponse))
    }
}
